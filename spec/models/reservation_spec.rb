require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @reserving_room = FactoryBot.create(:reservation, user: @user, room: @room)
  end

  it "has a valid factory" do
    expect(@reserving_room).to be_valid
  end
  
  it "user is reserving a room" do
    expect(@user.reserving?(@room)).to be_truthy
  end

  describe "user_id" do
    it "should be present" do
      @reserving_room.user_id = ""
      expect(@reserving_room).not_to be_valid
    end    
  end

  describe  "room_id" do
    it "should be present" do
      @reserving_room.room_id = ""
      expect(@reserving_room).not_to be_valid
    end    
  end
  
  describe  "start_date" do
    it "should be present" do
      @reserving_room.start_date= ""
      expect(@reserving_room).not_to be_valid
    end   
    
    it "should be invalid when before today" do
      @reserving_room.start_date = Date.today
      expect(@reserving_room).not_to be_valid
    end
  end

  describe  "end_date" do
    it "should be present" do
      @reserving_room.end_date= ""
      expect(@reserving_room).not_to be_valid
    end   
    
    it "should be invalid when earlier than start_date" do
      @reserving_room.end_date = Date.yesterday
      expect(@reserving_room).not_to be_valid
    end
  end

  describe "number_of_people" do
    it "should be present" do
      @reserving_room.number_of_people = " "
      expect(@reserving_room).not_to be_valid
    end

    it "should be greater than 0" do
      @reserving_room.number_of_people = 0  
      expect(@reserving_room).not_to be_valid
    end

    it "should be greater than 0" do
      @reserving_room.number_of_people = 3.5
      expect(@reserving_room).not_to be_valid
    end
  end

end
