class Exco < ActiveRecord::Base

  attr_accessible :name, :course_number, :description, :enrollment_limit, :year, :term

  TERMS = ['Fall', 'Spring']

  # Validations
  validates_presence_of :name, :course_number, :enrollment_limit, :year, :term
  validate :term_is_valid
  validate :course_number_and_name_are_unique_on_year_and_term
  validate :enrollment_limit_is_positive

  # the given term is in TERMS constant
  def term_is_valid
    errors.add(:term, 'is not valid') unless TERMS.include? self.term
  end

  # the given course_number does not duplicate within the same year and term
  def course_number_and_name_are_unique_on_year_and_term
    others = Exco.where(year: self.year, term: self.term, name: self.name)
    unless others.empty?
      errors.add(:name, "conflicts with #{others.first.name} (#{others.first.course_number}), #{self.term} #{self.year}") 
    end
    others = Exco.where(year: self.year, term: self.term, course_number: self.course_number)
    unless others.empty?
      errors.add(:course_number, "conflicts with #{others.first.name} (#{others.first.course_number}), #{self.term} #{self.year}") 
    end
  end

  # the given enrollment_limit is positive
  def enrollment_limit_is_positive
    if self.enrollment_limit
      errors.add(:enrollment_limit, 'must be positive') unless self.enrollment_limit > 0
    end
  end

end
