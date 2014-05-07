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
    @info = cookies[:id]
    if @info == nil
      flash[:error] = "You don't have any events saved yet. Please select events of interest to you."
      redirect_to events_path
    else
    	@info = cookies[:id].split('-')
    	@events = Event.all.where(id: @info)        
    end
  end

  def accordian
    time = Time.now.to_i.to_s
    @events = Event.all.where("date > ?", time).order("date ASC")
  end
end
