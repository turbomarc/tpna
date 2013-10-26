class ApplicationController < ActionController::Base

  unless Rails.env.test? || Rails.env.development?
    http_basic_authenticate_with :name => ENV['BASIC_AUTH_USER'], :password => ENV['BASIC_AUTH_PASSWORD']
  end

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
