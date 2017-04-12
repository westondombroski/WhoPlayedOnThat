class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :add_initial_breadcrumbs

  private

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', root_path
  end

  def current_user
    @current_user ||= User.find(session[:uid]) if session[:uid]
  end

  def authorize!
    redirect_to root_path unless current_user
  end
end
