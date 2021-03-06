class UsersController < ApplicationController
  before_action :logged_in_user, only: [:account, :profile, :update, :account_update, :reserving]
  before_action :correct_user, only: [:account, :profile, :update, :account_update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    if @user.save
      log_in @user
      flash[:success] = "#{@user.name}さん、Potepan Shareへようこそ!"
      redirect_to profile_user_url(@user)
    else
      render 'new'
    end
  end

  def account
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to profile_user_path(@user)
    else
      render 'profile'
    end
  end

  def account_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "アカウントを更新しました"
      redirect_to account_user_path(@user)
    else
      render 'account'
    end
  end

  def reserving
    @user = User.find(params[:id])
    @reservations = Reservation.find_by(room_id: @user.reserving.ids)
    @reserving_rooms = @user.reserving.paginate(page: params[:page], per_page: 32)
  end


  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :description, :image)
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
