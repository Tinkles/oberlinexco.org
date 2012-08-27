class Exco < ActiveRecord::Base

  attr_accessible :name, :course_number, :description, :enrollment_limit, :year, :term

  has_and_belongs_to_many :instructors, class_name: 'User', join_table: 'excos_instructors'
  attr_accessible :instructors, :instructors_attributes

  TERMS = ['Fall', 'Spring']

  validates_presence_of :name, :course_number, :enrollment_limit, :year, :term
  validate :term_is_valid
  validate :name_is_unique_on_year_and_term
  validate :course_number_is_unique_on_year_and_term
  validate :enrollment_limit_is_positive
  validates_associated :instructors, message: "are invalid"

  scope :by_offered, order("year DESC, term ASC")
  scope :by_course_number, order(:course_number)

  def term_is_valid
    errors.add(:term, 'is not valid') unless TERMS.include? self.term
  end

  def name_is_unique_on_year_and_term
    # we have to check id to make sure we're not selecting self
    others = Exco.where{|o| (o.year == self.year) & (o.term == self.term) & (o.name == self.name) & (o.id != self.id)}
    unless others.empty?
      errors.add(:name, "conflicts with #{others.first.name} (#{others.first.course_number}), #{self.term} #{self.year}") 
    end
  end

  def course_number_is_unique_on_year_and_term
    # we have to check id to make sure we're not selecting self
    others = Exco.where{|o| (o.year == self.year) & (o.term == self.term) & (o.course_number == self.course_number) & (o.id != self.id)}
    unless others.empty?
      errors.add(:course_number, "conflicts with #{others.first.name} (#{others.first.course_number}), #{self.term} #{self.year}") 
    end
  end

  def enrollment_limit_is_positive
    if self.enrollment_limit
      errors.add(:enrollment_limit, 'must be positive') unless self.enrollment_limit > 0
    end
  end

  # Returns the current excos.
  #
  # The cutoff month for Fall to Spring semesters is 1 January, and for Spring to Fall is 1 June
  def self.current
    Exco.where(:year => Date.today.year, :term => (Date.today.month > 5 ? 'Fall' : 'Spring')).order(:course_number)
  end

  # Returns the formatted string for when this exco was offered.
  def offered
    self.term.titleize + " " + self.year.to_s
  end

  # Ties this record to specified users as instructors.
  # Takes a hash of the form:
  #
  #   {"0"=>{"t_number"=>"T00000001", "_destroy"=>"false"},
  #    "1"=>{"t_number"=>"T12345678", "_destroy"=>"false"},
  #    "2"=>{"t_number"=>"", "_destroy"=>"1"}}
  #
  # If there is no user with the given t_number, we initialize dummy objects that
  # hold the value but are not saved in the database and thus are invalid
  #
  # This was built for creating Excos with instructors (see /app/views/excos/_form).
  def instructors_attributes=(attributes)
    self.instructors = []
    attributes.each do |i, instructor|
      self.instructors << User.find_or_initialize_by_t_number(instructor["t_number"]) unless instructor["_destroy"] == "1"
    end
  end

end
