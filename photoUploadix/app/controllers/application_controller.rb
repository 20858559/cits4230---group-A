class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  private
  #get current user_id source http://railscasts.com/episodes/250-authentication-from-scratch
  def current_user
    @_current_user ||= session[:user_id] && User.find(session[:user_id])
  end
end
