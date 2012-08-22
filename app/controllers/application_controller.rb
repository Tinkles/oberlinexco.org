class ApplicationController < ActionController::Base

  protect_from_forgery

  # for Grant
  before_filter :set_current_user

  # enforce checking authorization on every action in the application
  check_authorization unless: :devise_controller?

  # catch AccessDenied exceptions and reroute accordingly
  rescue_from CanCan::AccessDenied do |exception|

    if exception.subject.is_a? Exco or exception.subject == Exco
      redirect_to excos_path, :alert => exception.message
    else
      redirect_to root_url, :alert => exception.message
    end

  end

  private

  # for Grant
  def set_current_user
    Grant::User.current_user = @current_user
  end 


end
