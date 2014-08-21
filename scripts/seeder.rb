# rails runner

MEETUP_URL = 'https://api.meetup.com/2/open_events?&sign=true&category=34&zip=90034&radius=25&desc=true&limited_events=True&key='.freeze

MEETUP_GROUP_URL = 'https://api.meetup.com/2/groups?&sign=true&group_id='.freeze

MEETUP_RSVP_URL = 'https://api.meetup.com/2/rsvps?&sign=true&event_id='.freeze

MEETUP_API = '&key=593130547a1f163b6217506c832c49'.freeze

def seeder
  meetup_data_seeder
end

def meetup_data_seeder
  response = HTTParty.get (MEETUP_URL + MEETUP_API)
  data = response['results']
  # begin
  save_meetup_data(data)
  # rescue
    # return nil
  # end
end

def photo_seeder(group_id)
  data = HTTParty.get (MEETUP_GROUP_URL + group_id.to_s + MEETUP_API)
  begin
    picture = data['results'][0]['group_photo']['photo_link']
  rescue
    picture = nil
  end
    return picture
end

def save_meetup_data(data)
  events = []
  for i in 0...data.count
    event = Event.find_or_initialize_by(name: (data[i]['name']))
    if event.new_record?
      event.name = data[i]['name']
      event.description = data[i]['description']
      event.group = data[i]['group']['name']
      event.group_id = data[i]['group']['id']
      event.group_photo = photo_seeder(event.group_id)
      event.meetup_id = data[i]['id']
      event.url = data[i]['event_url']
      event.rsvp = data[i]['yes_rsvp_count']
      event.event_date = Event.date_converter(data[i]['time'])

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

seeder

