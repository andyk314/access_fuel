class EventsController < ApplicationController
  def index
  	Event.seeder()
  	time = Time.now.to_i.to_s
  	@events = Event.all.where("date > ?", time).order("date ASC")
  end

  def show
  	@event = Event.find(params[:id])
  end

  def favorite
  		@info = cookies[:id].split('-')
  		@events = Event.all.where(id: @info)
  end

  def accordian
    time = Time.now.to_i.to_s
    @events = Event.all.where("date > ?", time).order("date ASC")
  end


end
