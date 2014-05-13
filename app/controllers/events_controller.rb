class EventsController < ApplicationController
  def index
  	# Event.seeder()
  	time = Time.now.to_i.to_s
  	@events = Event.all.where("date > ?", time).order("date ASC")
  end

  def show
  	@event = Event.find(params[:id])
  end

  def favorite
    @arr = []
    cookies.each do |cookie|
      @arr.push(cookie)
    end
    @info = []

    for i in 0...@arr.length
      if @arr[i][0].index('id')
        @info.push(@arr[i][1])
      end
      @info
    end
    binding.pry
    if @info == []
      flash[:error] = "You don't have any events saved yet. Please select events of interest to you."
      redirect_to events_path
    else
      @events = Event.all.where(id: @info)        
    end
  end

  def accordian
    time = Time.now.to_i.to_s
    @events = Event.all.where("date > ?", time).order("date ASC")
  end
end
