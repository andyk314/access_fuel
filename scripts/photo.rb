MEETUP_GROUP_URL = 'https://api.meetup.com/2/groups?&sign=true&group_id='.freeze

MEETUP_API = '&key=593130547a1f163b6217506c832c49'.freeze


events = Event.where(group_photo:nil).where.not(group_id:nil)

for i in 10...events.count
  group = events[i].group_id
  puts i
  data = HTTParty.get (MEETUP_GROUP_URL + group.to_s + MEETUP_API)
  puts data
  picture = data['results'][0]['group_photo']['photo_link']
  events[i].group_photo = picture
  events[i].save
end
