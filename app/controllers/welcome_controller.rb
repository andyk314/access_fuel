class WelcomeController < ApplicationController
  def index
  	time = Time.now.to_i.to_s
  	@events = Event.all.where("date > ?", time).order("date ASC")
  	@upcoming_events = Event.all.where("date > ?", time).order("date ASC").limit(3)
  end
end
