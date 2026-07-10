# CREATE Product Openings
ProductOpening.delete_all

puts "Creating product openings..."

opening_types = [
  "Fix Window",
  "Swing and Top-hung Window",
  "Swing Door",
  "Sliding Door and Window"
]

Product.find_each do |product|
  opening_types.each do |type_title|
    description_html = <<~HTML
      <ul>
        <li>Series #{Faker::Alphanumeric.alphanumeric(number: 3).upcase} Nobile System</li>
        <li>Material #{Faker::Number.number(digits: 4)} – T6</li>
        <li>Functionality #{Faker::Lorem.sentence(word_count: 6)}</li>
      </ul>
    HTML

    product.product_openings.create!(
      title: type_title,
      description: description_html
    )
  end

  puts "  - Created openings for product: #{product.name}"
end

puts "Product openings created successfully!"
