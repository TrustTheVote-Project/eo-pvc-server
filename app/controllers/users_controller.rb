class UsersController < ApplicationController
  
  def index
    render plain: current_user.first_name
  end
  
end
