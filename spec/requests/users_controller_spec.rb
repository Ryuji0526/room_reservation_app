require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  include TestHelper

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end

  describe "profile / update" do
    it "should redirect profile when not logged in" do
      get profile_user_path(@user)
      expect(flash.empty?).to be_falsy
      expect(response).to redirect_to login_path
    end

    it "should redirect update when not loged in" do
      patch user_path(@user), params: {user: {name: @user.name}}
      expect(flash.empty?).to be_falsy
      expect(response).to redirect_to login_path
    end

    it "should redirect profile when logged in as wrong user" do
      log_in_as(@other_user)
      get profile_user_path(@user)
      expect(flash.empty?).to be_truthy
      expect(response).to redirect_to root_path
    end

    it "should redirect update when loged in as wrong user" do
      log_in_as(@other_user)
      patch user_path(@user), params: {user: {name: @user.name}}
      expect(flash.empty?).to be_truthy
      expect(response).to redirect_to root_path
    end
  end
end
