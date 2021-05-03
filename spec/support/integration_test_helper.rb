module IntegrationTestHelper  
  def log_in_as(user, remember_token: '1')
    visit root_path
    click_link "ログイン"
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    if remember_token == '1'
      check "session_remember_me"
    end
    click_button "ログイン"
  end  
end