json.events do |json|
	json.array!(@events) do |event|
		json.extract! event, :id, :name, :group, :description, :date, :venue, :address, :city, :state, :zip, :url, :rsvp
	end
end

