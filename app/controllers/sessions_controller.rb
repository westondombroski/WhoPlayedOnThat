class SessionsController < ApplicationController
  def create
    auth_credentials = request.env['omniauth.auth'].credentials
    auth_info = request.env['omniauth.auth'].info

    @user = User.find_or_create_by(auth_info["id"])
  end
end
