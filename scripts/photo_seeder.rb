require 'HTTParty'
require 'pry'

MEETUP_GROUP_URL = 'https://api.meetup.com/2/groups?&sign=true&group_id='.freeze

MEETUP_API = '&key=593130547a1f163b6217506c832c49'.freeze

def self.photo_seeder(group_id)
  puts group_id
  data = HTTParty.get (MEETUP_GROUP_URL + group.to_s + MEETUP_API)
  d = data['results']
  binding.pry
  info = d[0]['group_photo'] if d[0]['group_photo'].nil?
  puts info

    #picture = data['results'][0]['group_photo']['photo_link']

  #if picture.present?
    #return picture
  #end
end

events = Event.where(group_photo:nil)
puts events.length
events.each do |event|
  group_id = event.group_id
  picture = self.photo_seeder(group_id)
end
