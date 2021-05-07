# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "sample@rails.org",
             password:              "password",
             password_confirmation: "password")

User.create!(name:  "Other User",
             email: "other@rails.org",
             password:              "password",
             password_confirmation: "password")

# 追加のユーザーをまとめて生成する
20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.all
users.each do |user|
  40.times do
    name = Faker::Lorem.sentence(word_count: 5)
    description = Faker::Lorem.sentence(word_count: 20)
    address = Gimei.address.kanji
    user.rooms.create!(name: name, description: description, fee: 10000, address: address)
  end
end

