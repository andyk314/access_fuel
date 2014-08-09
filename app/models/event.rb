class Event < ActiveRecord::Base
	scope :tomorrow_events, -> {where(event_date: (Date.tomorrow.midnight)..Date.tomorrow.end_of_day)}
	scope :next_seven_days, -> { where("event_date < ?", Date.today + 7)}
	scope :events_all, -> { where('event_date > ?', (Date.today.midnight) )}
	scope :today_events, -> { where(event_date: (Date.today.midnight)..Date.today.end_of_day )}

	class << self

		def jobs
			all_events_by_asc_order.where("name LIKE ? OR description LIKE ?", '%Networking%', '%Networking%')
		end

		def silicon_beach
			all_events_by_asc_order.where(city: ['Santa Monica', 'Venice', 'Marina Del Rey'])
		end

		def pasadena
			all_events_by_asc_order.where("city LIKE ? OR venue LIKE ? OR description LIKE ?", '%Pasadena%', '%Pasadena%', '%Pasadena%')
		end

		def downtown
			all_events_by_asc_order.where("city LIKE ? OR venue LIKE ? OR venue LIKE ? OR description LIKE ?", '%Downtown%', '%Downtown%', '%DTLA%', '%DTLA%')
		end

		def los_angeles
			all_events_by_asc_order.where(city: ['Los Angeles', 'Culver City', 'El Segundo', 'Hawthorne', 'Redondo Beach', 'Topanga Canyon', 'West Hollywood', 'Studio City'])
		end

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

	MEETUP_URL = 'https://api.meetup.com/2/open_events?&sign=true&category=34&zip=90034&radius=25&desc=true&limited_events=True&key='.freeze

	MEETUP_GROUP_URL = 'https://api.meetup.com/2/groups?&sign=true&group_id='.freeze

	MEETUP_RSVP_URL = 'https://api.meetup.com/2/rsvps?&sign=true&event_id='.freeze

	MEETUP_API = '&key=593130547a1f163b6217506c832c49'.freeze

	def self.rsvp_updater(id)
		meetup = Event.find(id).meetup_id
		if meetup.present?
			data = HTTParty.get (MEETUP_RSVP_URL + meetup.to_s + MEETUP_API)
			begin
				count = data['meta']['total_count']
			rescue
				count = ''
			end
		end
		count
	end

	def self.rsvp_listings(id)
		meetup = Event.find(id).meetup_id
		if meetup.present?
			data = HTTParty.get (MEETUP_RSVP_URL + meetup.to_s + MEETUP_API)
			members = data['results']
			list = []
			members.each do |member|
				list << member['member']['name'].titleize
			end
			list.sort
		end
	end

	def self.seeder
		self.meetup_data_seeder
	end

	def self.meetup_data_seeder
		response = HTTParty.get (MEETUP_URL + MEETUP_API)
		data = response['results']
		begin
			self.save_meetup_data(data)
		rescue
			return nil
		end
	end

	def self.date_converter(time)
		Time.at(time.to_s[0..-4].to_i)
	end

	def self.photo_seeder(group_id)
		data = HTTParty.get (MEETUP_GROUP_URL + group_id.to_s + MEETUP_API)
		begin
			picture = data['results'][0]['group_photo']['photo_link']
		rescue
			picture = nil
		end
			return picture
	end

	def self.save_meetup_data(data)
		events = []
		for i in 0...data.count
			event = Event.find_or_initialize_by(name: (data[i]['name']))
			if event.new_record?
				event.name = data[i]['name']
				event.description = data[i]['description']
				event.group = data[i]['group']['name']
				event.group_id = data[i]['group']['id']
				event.group_photo = self.photo_seeder(event.group_id)
				event.meetup_id = data[i]['id']
				event.url = data[i]['event_url']
				event.rsvp = data[i]['yes_rsvp_count']
				event.event_date = self.date_converter(data[i]['time'])

				if data[i]['venue'].present?
					event.venue = data[i]['venue']['name']
					event.address = data[i]['venue']['address_1']
					event.city = data[i]['venue']['city']
					event.state =  data[i]['venue']['state']
					event.zip = data[i]['venue']['zip']
				end
				events << event
				event.save
			end
		end
	end

end
