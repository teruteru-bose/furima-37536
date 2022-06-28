FactoryBot.define do
  factory :purchase_post do
    post_code { "123-4567" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { "テスト市" }
    house_number { "テスト1-1" }
    building { "テストタワー" }
    phone_number { "09015859570" }
  end
end
