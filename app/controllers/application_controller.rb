class ApplicationController < ActionController::Base
  protect_from_forgery

  # enforce checking authorization on every action in the application
  check_authorization
end
