require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  include ApplicationHelper
  before do
    @user = FactoryBot.create(:user)    
    @other_user = FactoryBot.create(:user)    
    @room = FactoryBot.create(:room, user: @user)
    @other_user_room = FactoryBot.create(:room, user: @other_user)
    40.times do
      FactoryBot.create(:room, user: @user)
    end
  end
  
  # ユーザーは自分の登録したルームを確認できる
  it "registerd rooms successfully display" do
    log_in_as @user
    visit root_path
    click_link "登録済みルーム"
    expect(current_path).to eq registered_room_path(@user)
    expect(page).to have_selector 'h3', text: @user.rooms.count
    expect(page).to have_selector 'img.room-icon'
    expect(page).to have_selector 'ul.pagination', count: 1
    @user.rooms.paginate(page: 1, per_page: 32).each do |room|
      expect(page).to have_content room.name
    end
  end

  # ユーザーは有効なルームのみ登録できる
  it "user create a new room" do
    log_in_as @user
    visit root_path
    # 無効な送信
    click_link "ルーム登録"
    expect(current_path).to eq new_room_path
    expect {
      fill_in "名前", with: ""
      fill_in "説明", with: ""
      fill_in "料金 / 1拍", with: ""
      fill_in "住所", with: ""
      click_button "ルームを登録"
    }.to_not change(Room, :count)
    expect(page).to have_selector '#error_explanation'
    # 有効な送信
    visit root_path
    click_link "ルーム登録"
    img = "spec/files/kitten.jpg"
    expect {
      fill_in "名前", with: "room"
      fill_in "説明", with: "test"
      fill_in "料金 / 1拍", with: 10000
      fill_in "住所", with: "東京都千代田区"
      attach_file "ルーム画像",img
      click_button "ルームを登録"
    }.to change(Room, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_selector '.alert-success'
    visit room_path(@room)
    expect(page).to have_selector 'a', text: '編集'
    expect(page).to have_selector 'a', text: '削除する'
    # 投稿を削除する
    click_link '削除する'
    page.driver.browser.switch_to.alert.accept unless Capybara.javascript_driver == :poltergeist
    expect(current_path).to eq root_path
    expect(page).to have_selector '.alert-success'
    # 違うユーザーのプロフィールにアクセス(削除リンクがない)
    visit room_path(@other_user_room)
    expect(page).to_not have_selector 'a', text: '編集'
    expect(page).to_not have_selector 'a', text: '削除する'
  end
end
