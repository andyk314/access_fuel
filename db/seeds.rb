s = Roo::CSV.new("db/events.csv")
puts s.info
arr = []
s.each(:event_name => 'Event Name', :url => 'Webpage Link', :day => 'Day', :date => 'Start Date', :time => 'Start Time') { |hash|
	arr << hash
}

# puts arr

for i in 1...arr.count
  event = Event.find_or_initialize_by(name: (arr[i]['event_name']))
  event.name = arr[i][:event_name]
  event.venue = arr[i][:venue]
  event.url = arr[i][:url]
  date = arr[i][:date]
  time = arr[i][:time].split(' - ')[0]
  if date != nil and time != nil
	  d = Date.parse(date)
	  t = Time.parse(time)
	  puts d
	  puts t
	  dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
  	event.event_date = dt
   	# event.description
  	# event.group_photo
  	# event.rsvp
  	# event.address
  	# event.meetup_id
  	# event.group_id
  end
  event.save
end



# Event.destroy_all

# api = '593130547a1f163b6217506c832c49'
# url = 'https://api.meetup.com/2/open_events?&sign=true&category=34&zip=90034&radius=15&desc=true&limited_events=True&key='
# response = HTTParty.get (url + api)
# data = response['results']
# events = []

# for i in 0...data.count
# 	event = Event.find_or_initialize_by(name: (data[i]['name']))
# 	if event.new_record? and data[i]['venue'] != nil
# 		event.name = data[i]['name']
# 		event.description = data[i]['description']
# 		event.venue = data[i]['venue']['name']
# 		event.address = data[i]['venue']['address_1']
# 		event.city = data[i]['venue']['city']
# 		event.state =  data[i]['venue']['state']
# 		event.zip = data[i]['venue']['zip']
# 		event.group = data[i]['group']['name']
# 		event.rsvp = data[i]['yes_rsvp_count']
# 		event.url = data[i]['event_url']
# 		# t = Time.at(time.to_s[0..-4].to_i).utc.to_datetime
# 		# event.date = Time.at(data[i]['time'].to_s[0..-4].to_i).utc.to_datetime.strftime("%B %d, %Y")
# 		event.time = data[i]['time']
# 		event.date = data[i]['time']
# 		event.duration = data[i]['duration']
# 		events << event
# 		event.save
# 	else
# 		event.name = data[i]['name']
# 		event.description = data[i]['description']
# 		event.group = data[i]['group']['name']
# 		event.rsvp = data[i]['yes_rsvp_count']
# 		event.url = data[i]['event_url']
# 		event.time = data[i]['time']
# 		event.date = data[i]['time']
# 		event.duration = data[i]['duration']
# 		events << event
# 		event.save
# 	end
# end
