require 'rails_helper'

RSpec.describe "UsersLogins", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  # ログインに失敗する
  it "user failed log in" do
    visit root_path
    click_link "ログイン"
    fill_in 'メールアドレス', with: ""
    fill_in 'パスワード', with: ""
    click_button "ログイン"
    expect(page).to have_selector('.alert-danger')
    visit root_path
    expect(page).to_not have_selector('.alert-danger')
  end

  # ログインに失敗する
  it "user failed log in with invalid password" do
    visit root_path
    click_link "ログイン"
    fill_in 'メールアドレス', with: "test@rails.org"
    fill_in 'パスワード', with: "foo"
    click_button "ログイン"
    expect(page).to have_selector('.alert-danger')
    visit root_path
    expect(page).to_not have_selector('.alert-danger')
  end  

  # ログインに成功する
  it "user successfully log in" do
    log_in_as(@user)
    expect(page).to_not have_selector('.alert-danger')
    visit root_path
    expect(page).to have_selector('a', text: "ログアウト")
  end

  # ログアウトに成功する
  it "user successfully log out" do
    log_in_as(@user)
    click_link "ログアウト"
    expect(current_path).to eq root_path
    expect(page).to_not have_selector('a', text: "ログアウト")
    expect(page).to have_selector('a', text: "ログイン")
  end
end
