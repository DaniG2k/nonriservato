FactoryBot.define do
  factory :event do
    name 'Fantastic event'
    date_begun Time.zone.now
    date_ended 3.days.from_now
    description Faker::Lorem.sentence
    definition Faker::Lorem.sentence
    email 'some@email.com'
    image { File.new("#{Rails.root}/spec/fixtures/logo.png") }
    event_type 'some event type'
  end
end
