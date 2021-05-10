FactoryBot.define do
  factory :room do
    name { Faker::Lorem.sentence(word_count: 5) }
    description { "民宿です" }
    fee { 1000 }
    address { "神奈川県川崎市" }
    association :user 
  end
end
