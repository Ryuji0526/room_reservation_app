require 'rails_helper'

RSpec.describe "UsersSignup", type: :system do
  it "user successfully sign up" do
    visit root_path
    click_link "登録する"

    expect {
      fill_in "名前", with: "Michael"
      fill_in "メールアドレス", with: "test@rails.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード確認", with: "password"
      click_button "新しいアカウントを作成"
    }.to change(User, :count).by(1)
    expect(current_path).to eq profile_user_path(1)
    expect(page).to have_selector('.alert-success')
    expect(page).to have_selector('a', text: "ログアウト")
  end

  it "user faild sign up" do
    visit root_path
    click_link "登録する"

    expect {
      fill_in "名前", with: ""
      fill_in "メールアドレス", with: "user@invalid"
      fill_in "パスワード", with: "foo"
      fill_in "パスワード確認", with: "bar"
      click_button "新しいアカウントを作成"
    }.to_not change(User, :count)
    expect(page).to have_content "入力内容を確認してください"
    expect(page).to have_content "名前を入力してください"
    expect(page).to have_content "メールアドレスは不正な値です"
    expect(page).to have_content "パスワードは6文字以上で入力してください"
    expect(page).to have_content "パスワードとパスワードの入力が一致しません"
  end
end
