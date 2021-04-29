class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name}さん、Potepan Shareへようこそ!"
      redirect_to profile_user_url(@user)
    else
      render 'new'
    end
  end

  def account
  end

  def profile
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
