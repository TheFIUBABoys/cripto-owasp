class ApplicationController < ActionController::Base

  include ErrorHelper, SessionsHelper

  # XXX Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  helper_method :current_session, :current_user

  def current_session
    @current_session ||= Session.find_by(id: cookies.signed[:session]) if cookies.signed[:session]
  end

  def current_user
    @current_user ||= current_session.user if current_session
  end

end
