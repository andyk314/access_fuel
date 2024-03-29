class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :current_user
  def index
    # Event.seeder

    if params[:time_period] == "all"
      @events = Event.all_events_by_asc_order
    elsif params[:time_period] == "today"
      @events = Event.today_events_only
    elsif params[:time_period] == "tomorrow"
      @events = Event.tomorrow_events_only
    elsif params[:time_period] == "weekend"
      @events = Event.weekend_events_only
    elsif params[:time_period] == "nearest"
      @events = Event.nearest_events
    elsif params[:location] == 'beach'
      @events = Event.silicon_beach
    elsif params[:location] == "downtown"
      @events = Event.downtown
    elsif params[:location] == "los angeles"
      @events = Event.los_angeles
    elsif params[:location] == "pasadena"
      @events = Event.pasadena
    elsif params[:category] == "jobs"
      @events = Event.jobs
    elsif params[:time_period] == "fav"
      fav = cookies
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
      
       @events = Event.all_events_by_asc_order.where(id: @info)
    else
      @events = Event.all_events_by_asc_order
    end


    respond_to do |format|
      format.js
      format.html
    end

    
  end

  # def new
  #   @event = Event.new
  # end

  # def create
  #   _params = params.require(:event).permit(:name, :description, :venue, :address, :city, :state, :zip, :url, :group, :event_date, :group_photo)
  #   @event = Event.create(_params)
  #   if @event.errors.empty?
  #     redirect_to events_home_url, notice: 'Event Successfully Created'
  #   else
  #     render :new
  #   end
  # end

  def show
    @event = Event.find(params[:id])

    ##### Populate rsvp names going to event #####
    names = Event.rsvp_listings(params[:id])
    if names.present?
      @rsvp_names = names
    else
      @rsvp_names = ["List not available at this time"]
    end

    ##### Update rsvp count list ######
    @count = Event.rsvp_updater(params[:id])
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
      @events = Event.all_events_by_asc_order.where(id: @info)
    end
  end

end

