FactoryBot.define do
  factory :project do
    name { Faker::Company.unique.name }
    client_name { Faker::Company.name }
    caption { Faker::Lorem.sentence }
    short_description { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph(sentence_count: 5) }

    after(:build) do |project|
      project.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
      project.banner.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_banner.jpg')),
        filename: 'test_banner.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
