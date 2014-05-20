class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to events_path
    end
  end
end
