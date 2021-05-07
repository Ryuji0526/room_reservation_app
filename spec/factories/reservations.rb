FactoryBot.define do
  factory :reservation do
    start_date { Time.current.since(3.days)}
    end_date { Time.current.since(5.days)}
    total_fee { 1000 }
    number_of_people { 4 }   
    association :user 
    association :room
  end
end
