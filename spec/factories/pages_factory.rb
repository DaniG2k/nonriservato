FactoryBot.define do
  factory :page do
    title 'Some title'
    text Faker::Lorem.sentence
  end
end
