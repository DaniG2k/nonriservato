FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Amazing project #{n}" }
    date_begun 3.days.from_now
    definition Faker::Lorem.sentence
  end
end
