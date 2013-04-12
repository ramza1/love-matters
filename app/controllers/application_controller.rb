class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :sidebar

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def ensure_administrators
    redirect_to new_user_session_path if User.exists?
  end

  def sidebar
    HTTParty.get('http://www.punchng.com/sidebar')
  end
end
