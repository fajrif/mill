# CREATE Products
Product.delete_all

puts "Creating products..."

4.times do |i|
  product = Product.new(
    name: Faker::Commerce.unique.product_name,
    caption: Faker::Marketing.buzzwords,
    short_description: Faker::Lorem.sentence(word_count: 15),
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  # Attach main image
  product.image.attach(
    io: File.open(Rails.root.join("vendor/assets/images/products/product-#{i + 1}.png")),
    filename: "product-#{i + 1}.png",
    content_type: "image/png"
  )

  # Attach banner (randomly selected from banners folder)
  banner_num = rand(1..5)
  product.banner.attach(
    io: File.open(Rails.root.join("vendor/assets/images/banners/banner-#{banner_num}.png")),
    filename: "banner-#{banner_num}.png",
    content_type: "image/png"
  )
  product.save!

  puts "  - Created product: #{product.name}"
end

puts "Products created successfully!"
