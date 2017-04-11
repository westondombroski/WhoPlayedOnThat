class SessionsController < ApplicationController
  def create
    auth_credentials = request.env['omniauth.auth'].credentials
    auth_info = request.env['omniauth.auth'].info

    user = User.find_or_create_by(auth_info["id"]) || User.create_with_omniauth(auth_credentials)
    session[:uid] = user.id
    redirect_to root_path, :notice => "Signed in!"
  end

  def destroy
    session[:uid] = nil
    redirect_to root_path, notice: "Signed Out!"
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
