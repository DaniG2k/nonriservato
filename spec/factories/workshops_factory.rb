FactoryBot.define do
  factory :workshop do
    name "Some workshop"
    description Faker::Lorem.paragraph
    definition Faker::Lorem.sentence
    active true
    date_begun 2.days.from_now
    date_ended 1.week.from_now
  end
end
