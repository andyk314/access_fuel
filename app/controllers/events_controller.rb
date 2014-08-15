class EventsController < ApplicationController
  def index
    Event.seeder
    if params[:time_period] == "today"
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
  def form
     @event = Event.find(params[:id])
  end 
 

   def question

    @event = Event.find(params[:id])
    @questions = Question.all
    
  


      # @string1="https://api.meetup.com/2/event/"
      # @string2= @event.meetup_id.to_s
      # @string3= "?key=24546b334839224477224a4a265328&sign=true&photo-host=public&fields=survey_questions"
      # @string = @string1+@string2+@string3
      # @response = HTTParty.get(@string)




   # @data = @response.parsed_response["survey_questions"]



    # puts response.name
    @meetup_id = @event.meetup_id
    @user = current_user
   end 

  def edit
    @event = Event.find(params[:id])
  end

  def update
    
    @event = Event.find(params[:id])
    
    @user = current_user
    @event.owner_id = @user.id
    
    @event.save

    


    redirect_to events_path, notice: "Event Claimed"

  end 

  def show
    @event = Event.find(params[:id])
    @user = current_user
    
   

    ##### Populate rsvp names going to event #####
    names = Event.rsvp_listings(params[:id])
    if names.present?
      @rsvp_names = names
    else
      @rsvp_names = ["List not available at this time"]
    end

    ##### Update rsvp count list ######
    count = Event.rsvp_updater(params[:id])
    if count.present?
      @rsvp_count = count
    else
      @rsvp_count = ''
    end
  end

  def favorite
    @arr = []
    cookies.each do |cookie|
      @arr.push(cookie)
    endhtm
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




  def event_params
      params.require(:event).permit(:owner_id)
  end

end
end