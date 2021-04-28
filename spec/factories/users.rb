FactoryBot.define do
  factory :user do
    name {"Michael"}
    email {"test@rails.org"}
    password {"password"}
    password_confirmation {"password"}
  end
end
