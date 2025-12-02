FactoryBot.define do
  factory :event do
    title { Faker::Lorem.unique.sentence }
    short_description { Faker::Lorem.paragraph }
    published_date { Faker::Date.forward(days: 30) }
    status { 1 }
    video_url { "" }

    after(:build) do |event|
      event.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
