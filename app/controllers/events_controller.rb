class EventsController < ApplicationController
  def index
  	# @events = Event.all.where("date[0..-4].to_i > ?", 1)
  	@events = Event.all
  end

  def show
  	@event = Event.find(params[:id])
  end

  def favorite
  	@info = cookies[:id].split('-')
  	@events = Event.all.where(id: @info)



  end


end
