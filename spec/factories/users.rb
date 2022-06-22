FactoryBot.define do
  factory :user do
    nickname {Faker::Name}
    email {Faker::Internet.free_email}
    password {"123456test"}
    password_confirmation {password}
    last_name {"テスト"}
    first_name {"太郎"}
    last_name_kana {"テスト"}
    first_name_kana {"タロウ"}
    birthday {"2000-01-01"}
  end
end