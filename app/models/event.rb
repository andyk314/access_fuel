class Event < ActiveRecord::Base
	def self.seeder()
		api = '593130547a1f163b6217506c832c49'
		url = 'https://api.meetup.com/2/open_events?&sign=true&category=34&zip=90034&radius=15&desc=true&limited_events=True&key='
		response = HTTParty.get (url + api)
		data = response['results']
		events = []

		for i in 0...data.count
			event = Event.find_or_initialize_by(name: (data[i]['name']))
			if event.new_record?
				if data[i]['venue'] != nil
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
end
