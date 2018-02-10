FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Amazing post #{n}" }
    date_published Time.zone.now
    summary Faker::Lorem.sentence
  end
end
