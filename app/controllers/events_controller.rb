class EventsController < ApplicationController
  def index
  	# Event.seeder()
  	time = Time.now.to_i.to_s

    if params[:time_period] == "today"
      # @events = Event.santa_monica.where("date > ?", time).order("date ASC")
      # @events = Event.today_events.order("date ASC")
      @events = Event.today_events
      # binding.pry
    elsif params[:time_period] == "tomorrow"
      @events = Event.tomorrow_events
      # @events = Event.venice.where("date > ?", time).order("date ASC")
    elsif params[:time_period] == "weekend"
      @events = Event.weekend_events.where("event_date < ?", (Date.today + 14)).order("date ASC")
    else
      @events = Event.events_all.order("date ASC")
    end

  	# @events = Event.all.where("date > ?", time).order("date ASC")
    # @today = @events.where(:event_date == Date.today)


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
      @events = Event.all.where(id: @info).order("date ASC")        
    end
  end

  def accordian
    time = Time.now.to_i.to_s
    @events = Event.all.where("date > ?", time).order("date ASC")
  end
end

