class UsersController < ApplicationController
  def new
    render
  end

  def create
    redirect_to events_path
  end

  def setting
    render
  end

  def customize
    redirect_to events_path
  end
end
