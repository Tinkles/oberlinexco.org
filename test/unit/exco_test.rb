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

    context "an exco with the same course_number" do
      setup do
        @aikido_exco.course_number = 69
      end
      should "fail and have errors in course_number field" do
        assert @aikido_exco.invalid?
        assert @aikido_exco.errors[:course_number].any?
      end
    end

  end

end
