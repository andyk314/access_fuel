class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # sign_in(@user)
      MailChimp.subscribe_to_mailing_list(@user.id)
      redirect_to events_path, notice: "Signed Up"
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
