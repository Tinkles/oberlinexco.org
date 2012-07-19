require 'test_helper'

class ExcoTest < ActiveSupport::TestCase

  context "creating" do

    setup do
      @aikido_exco = Exco.new(name: "Aikido ExCo",
                              course_number: 1,
                              description: "Learn aikido.",
                              enrollment_limit: 16,
                              year: 2012,
                              term: "Spring")
    end

    context "a valid exco" do
      should "be valid" do
        assert @aikido_exco.valid?
      end
    end

    context "an exco with an empty description" do
      setup do
        @aikido_exco.description = nil
      end
      should "be valid" do
        assert @aikido_exco.valid?
      end
    end

    context "an empty exco" do
      setup do
        @empty_exco = Exco.new
      end
      should "be invalid and have errors in all required fields" do
        assert @empty_exco.invalid?
        assert @empty_exco.errors[:name].any?
        assert @empty_exco.errors[:course_number].any?
        assert @empty_exco.errors[:enrollment_limit].any?
        assert @empty_exco.errors[:year].any?
        assert @empty_exco.errors[:term].any?
      end
    end

    context "an exco with a bad term" do
      setup do
        @aikido_exco.term = "Summer"
      end
      should "be invalid and have an error in the term field" do
        assert @aikido_exco.invalid?
        assert @aikido_exco.errors[:term].any?
      end
    end

    context "an exco with a 0 enrollment_limit" do
      setup do
        @aikido_exco.enrollment_limit = 0
      end
      should "be invalid and have an error in the enrollment_limit field" do
        assert @aikido_exco.invalid?
        assert @aikido_exco.errors[:enrollment_limit].any?
      end
    end

    context "an exco with a -1 enrollment_limit" do
      setup do
        @aikido_exco.enrollment_limit = -1
      end
      should "be invalid and have an error in the enrollment_limit field" do
        assert @aikido_exco.invalid?
        assert @aikido_exco.errors[:enrollment_limit].any?
      end
    end

    context "an exco with the same name, year, and term" do
      setup do
        @aikido_exco.name = excos(:sexco).name
        @aikido_exco.year = excos(:sexco).year
        @aikido_exco.term = excos(:sexco).term
      end
      should "fail and have errors in name field" do
        assert @aikido_exco.invalid?
        assert @aikido_exco.errors[:name].any?
      end
    end

    context "an exco with the same course_number, year, and term" do
      setup do
        @aikido_exco.course_number = excos(:sexco).course_number
        @aikido_exco.year = excos(:sexco).year
        @aikido_exco.term = excos(:sexco).term
      end
      should "fail and have errors in course_number field" do
        assert @aikido_exco.invalid?
        assert @aikido_exco.errors[:course_number].any?
      end
    end

  end

end
