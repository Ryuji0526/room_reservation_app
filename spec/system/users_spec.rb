require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.create(:user, :with_reserving_rooms)
    @other_user = FactoryBot.create(:user)
    @other_room = FactoryBot.create(:room, name: 'other room')
    @other_user_reserving_room = FactoryBot.create(:reservation, user: @other_user, room: @other_room)
    log_in_as(@user)
  end
  
  describe "edit profile" do
    it "user failed edit" do
      visit root_path
      find('img.user-icon').click
      click_link '設定'
      expect(current_path).to eq profile_user_path(1)
      fill_in '名前', with: ""
      click_button '編集'  
      expect(page).to have_selector('#error_explanation')
    end

    it "user success edit with friendly worwarding" do
      visit profile_user_path(@user)
      expect(current_path).to eq profile_user_path(@user)
      name = "Foo Bar"
      description = "Hello World"
      fill_in '名前', with: name
      fill_in '自己紹介', with: description
      click_button '編集'
      @user.reload
      expect(page).to have_selector('.alert-success')
      expect(name).to eq @user.name
      expect(description).to eq @user.description    
    end
  end

  describe "user reserving" do
    it "should display rooms only user reserving" do
      visit root_path
      find('img.user-icon').click
      click_link '予約済みルーム'
      expect(page).to have_selector 'h3', text: "登録ルーム数: #{@user.reserving.count}件"
      rooms = @user.reserving.all
      expect(page).to have_selector 'tbody tr', count: @user.reserving.count
      # 他のユーザーが予約しているルームは表示されない
      expect(page).not_to have_content @other_room.name
      # 自分が予約してルーム全て表示される
      rooms.each do |room|
        expect(page).to have_content room.name
      end
    end
  end
end
