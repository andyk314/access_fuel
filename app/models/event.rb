class Event < ActiveRecord::Base
	scope :tomorrow_events, -> {where(event_date: (Date.tomorrow.midnight)..Date.tomorrow.end_of_day)}
	scope :next_seven_days, -> { where("event_date < ?", Date.today + 7)}
	scope :events_all, -> { where('event_date > ?', (Date.today.midnight) )}
	scope :today_events, -> { where(event_date: (Date.today.midnight)..Date.today.end_of_day )}

	class << self

		def converter(time)
			time.to_formatted_s(:time)
		end

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
			self.tomorrow_events.order('event_date ASC')
		end

		def saturday_events
			saturday = (Date.today.beginning_of_week + 5).midnight
			all_events_by_asc_order.where('event_date >= ?', saturday).order('event_date ASC')
		end

		def weekend_events_only
			sunday = Date.today.end_of_week.end_of_day
			saturday_events.where('event_date <= ?', sunday )
		end
	end

	def self.rsvp_updater(id)
		api = '&key=593130547a1f163b6217506c832c49'
		rsvp_url = 'https://api.meetup.com/2/rsvps?&sign=true&event_id='
		new_url = rsvp_url + id + api
		data = HTTParty.get new_url
		count = data['meta']['total_count']
		e = Event.find_by(meetup_id: id)
		e.rsvp = count
		e.save
	end

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
					event.meetup_id = data[i]['id']
					if event.group_id != nil
						picture_data = HTTParty.get (url3 + event.group_id.to_s + '&key=' + api)
						picture = picture_data['results'][0]
					
						if picture.has_key? 'group_photo'
							event.group_photo = picture['group_photo']['photo_link']
						end
					end

					event.rsvp = data[i]['yes_rsvp_count']
					event.url = data[i]['event_url']
					# event.time = data[i]['time']
					# event.date = data[i]['time']
					
					time = data[i]['time'].to_s[0..-4]
					event.event_date = Time.at(time.to_i)
					event.duration = data[i]['duration']
					events << event
					event.save
				else
					event.name = data[i]['name']
					event.description = data[i]['description']
					event.group = data[i]['group']['name']
					event.group_id = data[i]['group']['id']
					if event.group_id != nil
						picture_data = HTTParty.get (url3 + event.group_id.to_s + '&key=' + api)
						picture = picture_data['results'][0]
						if picture.has_key? 'group_photo'
							event.group_photo = picture['group_photo']['photo_link']
						end
					end

					event.rsvp = data[i]['yes_rsvp_count']
					event.url = data[i]['event_url']
					time = data[i]['time'].to_s[0..-4]
					event.event_date = Time.at(time.to_i)

					event.duration = data[i]['duration']
					events << event
					event.save
				end
			end
		end
	end
end
