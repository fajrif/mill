FactoryBot.define do
  factory :product do
    name { Faker::Commerce.unique.product_name }
    caption { Faker::Lorem.sentence }
    short_description { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph(sentence_count: 5) }

    after(:build) do |product|
      product.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
      product.banner.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_banner.jpg')),
        filename: 'test_banner.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
