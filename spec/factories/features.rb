FactoryBot.define do
  factory :feature do
    name { Faker::Lorem.unique.word }
    caption { Faker::Lorem.sentence }
    short_description { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph(sentence_count: 3) }

    after(:build) do |feature|
      feature.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
