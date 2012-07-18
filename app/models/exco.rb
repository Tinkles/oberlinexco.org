class Exco < ActiveRecord::Base

  attr_accessible :description, :name, :enrollment_limit, :year, :term

  validate :term_is_valid

  TERMS = ['Fall', 'Spring']

  # validate to make sure that the given term is in TERMS constant
  def term_is_valid
    errors.add(:term, 'is not valid') unless TERMS.include? term
  end

end
