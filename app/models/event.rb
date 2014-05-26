class Event < ActiveRecord::Base

	# scope :today_events, -> { where("event_date < ?", Date.tomorrow) }
	scope :tomorrow_events, -> { where("event_date > ?", Date.today)}
	scope :weekend_events, -> { where("event_date < ?", Date.today + 7)}
	# scope :events_all, -> { where("event_date > ?", Date.yesterday )}
	scope :events_all, -> { where('event_date > ?', (Date.today.midnight - 1.day)      )}
	scope :today_events, -> { where(event_date: (Date.today.midnight - 1.day)..Date.today.midnight )}

	class << self

		def date_converter(date)
			t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
			t.strftime('%B %e')
		end

		def all_events_by_asc_order
			self.events_all.order('event_date ASC')
		end

		def today_events_only
			self.today_events.order('event_date ASC')
		end

		def tomorrow_events_only
			self.tomorrow_events.where("event_date < ?", Date.tomorrow + 1).order('event_date ASC')
		end

		def saturday_events
			event = self.weekend_events.order('event_date ASC')
			start = Date.today.beginning_of_week
			last = start + 5
			event.where('event_date >= ?', last)
		end

		def weekend_events_only
			start = Date.today.beginning_of_week
			last = start + 7
			saturday_events.where('event_date < ?', last)
		end
	end

# binding.pry
	def self.seeder()
		api = '593130547a1f163b6217506c832c49'
		url = 'https://api.meetup.com/2/open_events?&sign=true&category=34&zip=90034&radius=15&desc=true&limited_events=True&key='
		url3 = 'https://api.meetup.com/2/groups?&sign=true&group_id='
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
					event.group_id = data[i]['group']['id']
					# binding.pry
					# 	if event.group_id != nil
					# 		picture_data = HTTParty.get (url3 + event.group_id.to_s + '&key=' + api)
					# 		datafile = picture_data['results']
					# 		datafile.each do |file|
					# 			event.group_photo = file['group_photo']['photo_link']
					# 		end
					# 	end

					event.rsvp = data[i]['yes_rsvp_count']
					event.url = data[i]['event_url']
					event.time = data[i]['time']
					event.date = data[i]['time']
					
					time = data[i]['time'].to_s[0..-4]
					time_converted = Time.at(time.to_i).to_datetime
					event.event_date = time_converted
					event.duration = data[i]['duration']
					events << event
					event.save
				else
					event.name = data[i]['name']
					event.description = data[i]['description']
					event.group = data[i]['group']['name']
					# event.event_date = data[i]['time'][0..-4]
					event.group_id = data[i]['group']['id']
					# 	picture_data = HTTParty.get (url3 + event.group_id.to_s + '&key=' + api)
					# 	datafile = picture_data['results']
					# 	datafile.each do |file|
					# 			if file['group_photo']['photo_link'] != []
					# 				event.group_photo = file['group_photo']['photo_link']
					# 			else 
					# 				event.group_photo = ''
					# 			end
					# 	end

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
