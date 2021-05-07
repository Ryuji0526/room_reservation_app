FactoryBot.define do
  factory :user do
    name {"Michael"}
    sequence(:email) {|n| "tester-#{n}@example.com" }
    password {"password"}
    password_confirmation {"password"}
  end

  trait :with_reserving_rooms do
    after(:create) {|user| create_list(:reservation, 5, user: user)}
  end
end
