class RoomsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @rooms = @q.result(distinct: true).paginate(page: params[:page], per_page: 32)
  end

  def show
    @room = Room.find(params[:id])
    @reservation = current_user.reservations.build
  end

  def registered
    @rooms = current_user.feed.paginate(page: params[:page], per_page: 32)
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    @room.image.attach(params[:room][:image])
    if @room.save
      flash[:success] = "ルームを登録しました"
      redirect_to root_path
    else
      @rooms = current_user.feed.paginate(page: params[:page], per_page: 32)
      render 'new'
    end
  end

  def update
    if @room.update(room_params)
      flash[:success] = "ルームを更新しました"
      redirect_to room_path(@room)
    else
      render 'profile'
    end
  end

  def destroy
    @room.destroy
    flash[:success] = "ルームを削除しました"
    redirect_to root_path
  end

  private
    def room_params
      params.require(:room).permit(:name,:description,:image,:fee,:address)
    end

    def correct_user
      @room = current_user.rooms.find_by(id: params[:id])
      redirect_to root_url if @room.nil?
    end
end
