require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  include TestHelper
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room, user: @user)
    @other_users_room = FactoryBot.create(:room, user: @other_user)
  end

  describe "GET /index" do
    it "returns http success" do
      log_in_as @user
      get rooms_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      log_in_as @user
      get new_room_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      log_in_as @user
      get edit_room_path(@user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "should redirect creawe when not logged in" do
      expect {
        post rooms_path, params: {room: {name: "test", description: "test", address: "address", fee: 1000}}      
      }.to_not change(Room, :count)
      expect(response).to redirect_to login_path
    end      
    
    it "should redirect creawe when logged in" do
      log_in_as @user
      expect {
        post rooms_path, params: {room: {name: "test", description: "test", address: "address", fee: 1000}}      
      }.to change(Room, :count).by(1)
      expect(response).to redirect_to root_path
    end
  end

  describe "#destroy" do
    it "should redirect destroy when not logged in" do
      expect {
        delete room_path(@room)
      }.to_not change(Room, :count)
      expect(response).to redirect_to login_path
    end

    it "should redirect destroy when not logged in" do
      log_in_as(@user)
      expect {
        delete room_path(@room)
      }.to change(Room, :count).by(-1)
      expect(response).to redirect_to root_path
    end

    it "should redirect destroy for wrong room" do
      log_in_as(@user)
      expect {
      delete room_path(@other_users_room)
      }.to_not change(User, :count)
      expect(response).to redirect_to root_path
    end

  end

end
