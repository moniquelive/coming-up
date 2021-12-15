class SessionsController < ApplicationController
  # If you're using a strategy that POSTs during callback,
  # you'll need to skip the authenticity token check for the callback action only.
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    sign_in(user)
    redirect_to '/'
  end

  def destroy
    sign_out
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
