require 'nokogiri'
require 'open-uri'
require 'roo'
require 'pry'
require 'yaml'

URL = 'https://generalassemb.ly/'
GROUP = 'General Assembly'
s = Roo::CSV.new("db/events3.csv")

def csv_to_array(ga_events)
  events_array = []
  ga_events.each(:ga_id => 'id',:name => 'Event Name', :format => 'format', :date => 'starts', :venue => 'campus_name', :address => 'address', :city => 'city', :state => 'state', :zip => 'zip_code') do |hash|
  	events_array << hash
  end
  event_seed(events_array)
end

def event_seed(events_array)
  events_array.each_with_index do |event, index|
    unless index == 0
      save_event(event)
    end
  end
end

def save_event(event)
  event = Event.find_or_initialize_by(event)
  event.url = URL + event[:format] + '/' + event[:name].downcase.gsub(/\s/,'-') + '/los-angeles/' + event[:ga_id].to_s
  event.group_photo = image_scraper(event.url)
  #event.description = description_scraper(event.url)
  event.group = GROUP
  event.event_date = event.date
  event.event_date -= 8.hour
  event.save
end


def image_scraper(url)
  images = []
  begin
    doc = Nokogiri::HTML(open(url))
  rescue
    return nil
  end
  doc.css('img').each do |img|
    images << img
  end
    return images[2].attributes['src'].value
end

=begin
def description_scraper(url)
  desc_array = []
  begin
    doc = Nokogiri::HTML(open(url))
  rescue
    return nil
  end
  doc.css('section.section-pod p').each do |d|
    desc_array << d
  end
    return desc_array.first.content
end
=end


csv_to_array(Roo::CSV.new("db/events3.csv"))


