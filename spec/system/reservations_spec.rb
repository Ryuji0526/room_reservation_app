require 'rails_helper'

RSpec.describe "Reservations", type: :system do
  describe "reserve form" do
    before do  
      @user = FactoryBot.create(:user)
      @room = FactoryBot.create(:room)
      log_in_as @user
      visit room_path(@room)
      @d = Date.today
    end

    it "user failed reserve room with invalid value" do      
      fill_in '開始日', with: @d
      fill_in '終了日', with: @d - 2
      fill_in '人数', with: ""
      click_button "確認画面へ"
      expect(page).to have_selector('#error_explanation')
    end

    it "user successfuly send reserving form with valid value" do      
      fill_in '開始日', with: @d + 1
      fill_in '終了日', with: @d + 2
      fill_in '人数', with: 3
      click_button "確認画面へ"
      expect(current_path).to eq confirm_reservations_path
      expect(page).to have_field "開始日", with: @d + 1
      expect(page).to have_field "終了日", with: @d + 2
      expect(page).to have_field "人数", with: 3
      expect(page).to have_field "総額", with: get_total_fee(3, @d + 1, @d + 2)
      expect(page).to have_link '入力画面に戻る', href: room_path(@room)
      expect{ 
        click_button '予約する'      
      }.to change(Reservation, :count).by(1)
      expect(current_path).to eq reserving_user_path(@user)
      expect(page).to have_selector '.alert-success'      
    end
  end
end
