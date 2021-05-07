class ReservationsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]

  def confirm
    @room = Room.find_by(id: params[:reservation][:room_id]) 
    @reservation = current_user.reservations.build(reservation_params)
    @total_fee = get_total_fee if @reservation.valid?
    render template: 'rooms/show' if @reservation.invalid?
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      flash[:success] = "ルームを予約しました"
      redirect_to reserving_user_path(current_user)
    else
      render template: 'rooms/show'
    end
  end

  def destroy
    @reservation.destroy
    flash[:success] = "予約をキャンセルしました。"
    redirect_to root_path
  end

  private

    def correct_user
      @reservation = current_user.reservations.find_by(id: params[:id])
      redirect_to root_url if @reservation.nil?
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :number_of_people, :room_id, :total_fee, :user_id)
    end

    def get_total_fee
      @room.fee * @reservation.number_of_people * (params[:reservation][:end_date].to_date - params[:reservation][:start_date].to_date).to_i
    end

end
