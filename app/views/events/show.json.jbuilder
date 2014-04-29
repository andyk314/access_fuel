json.event do |json|
	json.extract! event, :id, :name, :group, :description, :date, :venue, :address, :city, :state, :zip, :url, :rsvp
end

