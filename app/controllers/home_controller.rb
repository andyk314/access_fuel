class HomeController < ApplicationController
  before_action :check_user
  def index
    @users = User.all
    @user = User.new
    render
  end

  private
    def check_user
      if current_user
        binding.pry
        redirect_to events_path
      end
    end
end
