class ApplicationController < ActionController::Base

  protect_from_forgery

  # enforce checking authorization on every action in the application
  check_authorization

  # catch AccessDenied exceptions and reroute accordingly
  rescue_from CanCan::AccessDenied do |exception|

    if exception.subject.is_a? Exco or exception.subject == Exco
      redirect_to excos_path, :alert => exception.message
    else
      redirect_to root_url, :alert => exception.message
    end

  end

end
