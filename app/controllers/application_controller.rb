class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  private

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    session[:session_token] = user.reset_token!
  end

  def sign_out
    current_user.reset_token! if signed_in?
    session[:session_token] = nil
  end

  def require_signed_in!
    unless signed_in?
      render text: "You must log in!", status: 401
    end
  end
end
