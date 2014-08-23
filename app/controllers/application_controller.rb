class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

    helper_method :date_converter, :month_converter, :day_converter, :weekday_converter, :time_converter, :current_user
  
  def current_user
    #@current_user ||= User.find_by_id(session['user_id'])
    @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end

	def date_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%B %e')
	end

	def month_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%b')
	end

	def day_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%e')
	end

	def weekday_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).utc.to_datetime
		t.strftime('%a')
	end

	def time_converter(date)
		t = Time.at(date.to_s[0..-4].to_i).to_datetime
		t.strftime('%l:%M %P')
	end
	
end
