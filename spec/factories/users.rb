FactoryBot.define do
  factory :user do
    name {"Michael"}
    sequence(:email) {|n| "tester-#{n}@example.com" }
    password {"password"}
    password_confirmation {"password"}
  end

end
