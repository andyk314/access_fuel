class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def all
  #   raise request.env["omniauth.auth"].to_yaml
  # end
  # alias_method :meetup, :all


  def all
  user = User.from_omniauth(request.env["omniauth.auth"])
  if user.persisted?
    sign_in_and_redirect user, notice: "Signed in!"
  else
    session["devise.user_attributes"] = user.attributes
    redirect_to new_user_registration_url
  end
end
  alias_method :meetup, :all
end