class EventsController < ApplicationController
  def index
    # Event.seeder()
  	current_time = Time.now.to_i.to_s
    if params[:time_period] == "today"
      @events = Event.today_events
    elsif params[:time_period] == "tomorrow"
      @events = Event.tomorrow_events
    elsif params[:time_period] == "weekend"
      @events = Event.weekend_events.where("event_date < ?", (Date.today + 14)).order("date ASC")
    else
      @events = Event.events_all.order("date ASC")
    end

    respond_to do |format|
      format.js
      format.html
    end
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

    if @info == []
      flash[:error] = "You don't have any events saved yet. Please select events of interest to you."
      redirect_to events_path
    else
      @events = Event.where(id: @info).order("date ASC")        
    end
  end
end

