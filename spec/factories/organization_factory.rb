FactoryBot.define do
  factory :organization do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    sequence(:name) { Faker::Name.first_name }
    definition Faker::Lorem.sentence

    trait :admin do
      admin true
    end
  end
end
