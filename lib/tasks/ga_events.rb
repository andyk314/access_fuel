
s = Roo::CSV.new("GA-LA 2014 Schedule for Rob - 2014 Schedule.csv")

arr = []
s.each(event_name: 'Event Name',
    venue: 'Venue',
    url: 'Webpage Link',
    day: 'Day',
    date: 'Start Date',
    time: 'Start Time',
    price: 'Price') s
    {|hash| arr << hash }

for i in 1...arr.count
  event = Event.find_or_initialize_by(name: (arr[i]['event_name']))
  event.name = arr[i]['event_name']
  event.venue = arr[i]['venue']
  event.url = arr[i]['url']
  date = arr[i]['date']
  time = arr[i]['time']
  d = Date.parse(date)
  t = Time.parse(time)
  dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
  event.event_date = dt
  event.save
end