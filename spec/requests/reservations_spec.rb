require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  include TestHelper
  before do
    @user = FactoryBot.create(:user, :with_reserving_rooms)
    @room = FactoryBot.create(:room)
    @d = Date.today
  end
  
  describe "#create" do
    it "should redirect create when not logged in" do
      expect {
        post reservations_path, params: {reservation: {user_id: @user.id, room_id: @room.id, start_date: @d + 1, end_date: @d + 2, number_of_people: 3, total_fee: 1000}}
      }.to_not change(Reservation, :count)
      expect(response).to redirect_to login_path
    end

    it "should seccessufully create when logged in" do
      log_in_as @user
      expect {
        post reservations_path, params: {reservation: {user_id: @user.id, room_id: @room.id, start_date: @d + 1, end_date: @d + 2, number_of_people: 3, total_fee: 1000}}
      }.to change(Reservation, :count).by(1)
      expect(response).to redirect_to reserving_user_path(@user)
    end
  end

  describe "destroy" do
    before do
      @other_user = FactoryBot.create(:user)
      @reserving_room = FactoryBot.create(:reservation, user: @user)
      @other_reserving_room = FactoryBot.create(:reservation, user: @other_user)
    end

    it "should redirect destroy when not logged in" do
      expect {
        delete reservation_path(@reserving_room)
      }.to_not change(Reservation, :count)
      expect(response).to redirect_to login_path
    end

    it "should successfully destroy when logged in" do
      log_in_as @user
      expect {
        delete reservation_path(@reserving_room)
      }.to change(Reservation, :count)
      expect(response).to redirect_to root_path
    end

    it "should redirect destroy when deltet wrong room" do
      log_in_as @user
      expect {
        delete reservation_path(@other_reserving_room)
      }.not_to change(Reservation, :count)
      expect(response).to redirect_to root_path
    end
  end
end
