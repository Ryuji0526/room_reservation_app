require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room, created_at: 1.hours.ago)
    @fastest = FactoryBot.create(:room)
    10.times do 
      FactoryBot.create(:room, created_at: 1.hours.ago)
    end
  end

  it "has a valid factory" do
    expect(@room).to be_valid
  end

  it "user id should be present" do
    @room.user_id = nil
    expect(@room).not_to be_valid
  end

  describe "description" do
    it "sholud be present" do
      @room.description = " "
      expect(@room).not_to be_valid
    end

    it "should be at most 200 characters" do
      @room.description = "a" * 201
      expect(@room).not_to be_valid
    end
  end

  describe "name" do
    it "sholud be present" do
      @room.name = " "
      expect(@room).not_to be_valid
    end

    it "should be at most 50 characters" do
      @room.name = "a" * 51
      expect(@room).not_to be_valid
    end
  end

  describe "fee" do
    it "should permit only integer" do     
      @room.fee = 100.1
      expect(@room).not_to be_valid
    end
  end

  describe "order" do
    it "should be cheepest first" do
      expect(@fastest).to eq Room.first
    end
  end
end
