class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  	helper_method :date_converter, :month_converter, :day_converter, :weekday_converter, :time_converter

	def date_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%B %e')
	end

	def month_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%b')
	end

	def day_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%e')
	end

	def weekday_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%a')
	end

	def time_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).to_datetime
		t.strftime('%l:%M %P')
	end

	def seeder()
		api = '593130547a1f163b6217506c832c49'
		url = 'https://api.meetup.com/2/open_events?&sign=true&category=34&zip=90034&radius=15&desc=true&limited_events=True&key='
		response = HTTParty.get (url + api)
		data = response['results']
		events = []

		for i in 0...data.count
			event = Event.find_or_initialize_by(name: (data[i]['name']))
			if event.new_record? and data[i]['venue'] != nil
				event.name = data[i]['name']
				event.description = data[i]['description']
				event.venue = data[i]['venue']['name']
				event.address = data[i]['venue']['address_1']
				event.city = data[i]['venue']['city']
				event.state =  data[i]['venue']['state']
				event.zip = data[i]['venue']['zip']
				event.group = data[i]['group']['name']
				event.rsvp = data[i]['yes_rsvp_count']
				event.url = data[i]['event_url']
				event.time = data[i]['time']
				event.date = data[i]['time']
				event.duration = data[i]['duration']
				events << event
				event.save
			else
				event.name = data[i]['name']
				event.description = data[i]['description']
				event.group = data[i]['group']['name']
				event.rsvp = data[i]['yes_rsvp_count']
				event.url = data[i]['event_url']
				event.time = data[i]['time']
				event.date = data[i]['time']
				event.duration = data[i]['duration']
				events << event
				event.save
			end
		end
	end
	


end
