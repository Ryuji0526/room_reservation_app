require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it "has a valid factory" do
    expect(@user).to be_valid
  end

  describe "name" do    
    it "should be present" do
      @user.name = ""
      expect(@user).to_not be_valid
    end

    it "name should not be too long" do
      @user.name = "a" * 51
      expect(@user).to_not be_valid    
    end
  
    it "name should not be too long" do
      @user.email = "a" * 255 + "@rails.org"
      expect(@user).to_not be_valid    
    end
  end

  describe "email" do
    it "email should be present" do
      @user.email = ""
      expect(@user).to_not be_valid
    end

    it "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  
    it "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end
  
    it "email addres should be unique" do
      other_user = @user.dup 
      @user.save
      expect(other_user).to_not be_valid
    end
  
    it "email addresses should be saved as lower-case" do
      mixed_case_email = "TEst@ExAMPle.Com"
      @user.email = mixed_case_email
        @user.save
      expect(@user.email).to eq mixed_case_email.downcase
    end
  end

  describe "password" do
    it "password should be present (noblank)" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).to_not be_valid
    end

    it "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).to_not be_valid
    end
  end
end
