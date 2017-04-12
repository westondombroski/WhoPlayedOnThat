class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.create_with_omniauth(auth_hash)
    session[:uid] = user.id
    redirect_to root_path, notice: "Signed In!"
  end

  def destroy
    session[:uid] = nil
    redirect_to root_path, notice: "Signed Out!"
  end

  def failure
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
