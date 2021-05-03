require 'rails_helper'

RSpec.describe "UsersProfile", type: :system do
  before do
    @user = FactoryBot.create(:user) 
  end
  
  it "user failed edit profile" do
    log_in_as(@user)
    visit root_path
    click_link '設定'
    expect(current_path).to eq profile_user_path(1)
    fill_in '名前', with: ""
    click_button '編集'  
    expect(page).to have_selector('#error_explanation')
  end

  it "user successfully edit profile with friendly worwarding" do
    visit profile_user_path(@user)
    log_in_as(@user)
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
