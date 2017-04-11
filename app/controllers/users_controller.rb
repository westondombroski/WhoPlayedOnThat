class UsersController < ApplicationController
  def new
    @user = User.create_with_omniauth(request.env["omniauth.auth"])
  end
end
