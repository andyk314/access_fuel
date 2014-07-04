class UsersController < ApplicationController
  def new
  end

  def create
    redirect_to events_path
  end
  
end
