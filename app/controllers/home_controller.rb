class HomeController < ApplicationController

  skip_authorization_check

  def index
    @excos = Exco.current.by_course_number
  end

  def apply_to_teach
  end

end
