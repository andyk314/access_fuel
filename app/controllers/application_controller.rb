class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  before_action :configure_permitted_parameters, if: :devise_controller?		  
  protect_from_forgery with: :exception

  	helper_method :date_converter, :month_converter, :day_converter, :weekday_converter, :time_converter

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

	 # def configure_permitted_parameters
  #   	devise_parameter_sanitizer.for(:sign_up) << :meetup_organizer
  # 	end
	
	
 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :meetup_organizer
    devise_parameter_sanitizer.for(:account_update) << :meetup_organizer
  end	
end
