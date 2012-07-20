require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "creating" do

    setup do
      @ben = User.new(email: "ben@pres.com",
                      last_name: "Benjamin",
                      first_name: "Franklin",
                      t_number: "T00000010",
                      password: "akeyandlightning")
    end

    context "a valid user" do
      should "be valid" do
        assert @ben.valid?
      end
    end

    context "an empty user" do
      setup do
        @empty_user = User.new
      end
      should "be invalid and have errors in all required fields" do
        assert @empty_user.invalid?
        assert @empty_user.errors[:email].any?
        assert @empty_user.errors[:first_name].any?
        assert @empty_user.errors[:last_name].any?
        assert @empty_user.errors[:t_number].any?
      end
    end

    context "a user with a duplicate email" do
      setup do
        @ben.email = users(:george).email
      end
      should "be invalid and have an error in the email field" do
        assert @ben.invalid?
        assert @ben.errors[:email].any?
      end
    end

    context "a user with a duplicate t_number" do
      setup do
        @ben.t_number = users(:george).t_number
      end
      should "be invalid and have an error in the t_number field" do
        assert @ben.invalid?
        assert @ben.errors[:t_number].any?
      end
    end

    context "a user with a bad email" do
      setup do
        @ben.email = "badbadbad"
      end
      should "be invalid and have an error in the email field" do
        assert @ben.invalid?
        assert @ben.errors[:email].any?
      end
    end

    context "an exco with a bad t_number" do
      setup do
        @ben.t_number = "00000000"
      end
      should "be invalid and have an error in the t_number field" do
        assert @ben.invalid?
        assert @ben.errors[:t_number].any?
      end
    end

  end

end
