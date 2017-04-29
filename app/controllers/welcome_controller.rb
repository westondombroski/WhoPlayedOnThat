class WelcomeController < ApplicationController
  def index
    @root_path = root_path
    @home_page = true
  end
end
