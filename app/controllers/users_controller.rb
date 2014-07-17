class UsersController < ApplicationController
  def new
    render
  end

  def create
    @user = User.create(user_params)
    if @user.errors.empty?
      sign_in(@user)
      redirect_to events_path
    else
      render :new
    end
  end

  def setting
    render
  end

  def customize
    redirect_to events_path
  end

  def destroy
    sign_out(@user)
    redirect_to events_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
