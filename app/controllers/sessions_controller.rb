class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to events_path, notice: "Logged In"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session['user_id'] = nil
    # cookies.delete(:auth_token)
    redirect_to events_path, notice: "Logged Out"
  end
end