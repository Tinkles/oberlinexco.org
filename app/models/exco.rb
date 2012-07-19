class Exco < ActiveRecord::Base

  attr_accessible :name, :course_number, :description, :enrollment_limit, :year, :term

  # Validations
  validates_presence_of :name, :course_number, :enrollment_limit, :year, :term
  validate :term_is_valid
  validate :course_number_is_unique_on_year_and_term

  TERMS = ['Fall', 'Spring']

  # validate to make sure that the given term is in TERMS constant
  def term_is_valid
    errors.add(:term, 'is not valid') unless TERMS.include? self.term
  end

  # validate to make sure that the given course_number does not duplicate within the same year and term
  def course_number_is_unique_on_year_and_term
    others = Exco.where(:year => self.year, :term => self.term, :course_number => self.course_number)
    unless others.empty?
      errors.add(:course_number, "conflicts with #{others.first.name}, #{self.term} #{self.year}") 
    end
  end

end
