class Exco < ActiveRecord::Base

  attr_accessible :name, :course_number, :description, :enrollment_limit, :year, :term

  has_and_belongs_to_many :instructors, class_name: 'User', join_table: 'excos_instructors'
  attr_accessible :instructors

  TERMS = ['Fall', 'Spring']

  validates_presence_of :name, :course_number, :enrollment_limit, :year, :term, :instructors
  validate :term_is_valid
  validate :name_is_unique_on_year_and_term
  validate :course_number_is_unique_on_year_and_term
  validate :enrollment_limit_is_positive

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

end
