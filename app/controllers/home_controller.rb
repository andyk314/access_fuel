class HomeController < ApplicationController
  #before_action :check_authenticate
  def index
    if current_user
      redirect_to events_path
    else
      render
    end
  end

  # private
  #   def check_authenticate
  #     if current_user
  #       redirect_to events_path
  #     end
  #   end
end
