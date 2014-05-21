class Event < ActiveRecord::Base

	scope :today_events, -> { where('date_converter(date) > ?', Date.today)}
	scope :tomorrow_events, -> { where('date > ?', Date.tomorrow )}
	scope :weekend_events, -> { where('date > ?', (Date.today + 7) )}

	scope :santa_monica, -> { where(city: 'Santa Monica')}
	scope :venice, -> { where(city: 'Venice')}
	scope :los_angeles, -> { where(city: 'Los Angeles')}


	def date_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%B %e')
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
					event.event_date = Time.at(data[i]['time'][0..-4].to_i)
					event.duration = data[i]['duration']
					events << event
					event.save
				else
					event.name = data[i]['name']
					event.description = data[i]['description']
					event.group = data[i]['group']['name']

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
