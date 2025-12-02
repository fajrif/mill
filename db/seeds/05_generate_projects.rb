# CREATE Projects
Project.delete_all

puts "Creating projects..."

4.times do |i|
  project = Project.new(
    name: Faker::Company.unique.name + " " + Faker::Commerce.product_name,
    client_name: Faker::Company.name,
    caption: Faker::Marketing.buzzwords,
    short_description: Faker::Lorem.sentence(word_count: 15),
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  # Attach main image
  project.image.attach(
    io: File.open(Rails.root.join("vendor/assets/images/projects/project-#{i + 1}.png")),
    filename: "project-#{i + 1}.png",
    content_type: "image/png"
  )

  # Attach multiple gallery images (all available project images)
  4.times do |j|
    project.images.attach(
      io: File.open(Rails.root.join("vendor/assets/images/projects/project-#{j + 1}.png")),
      filename: "project-gallery-#{j + 1}.png",
      content_type: "image/png"
    )
  end

  # Attach banner (randomly selected from banners folder)
  banner_num = rand(1..5)
  project.banner.attach(
    io: File.open(Rails.root.join("vendor/assets/images/banners/banner-#{banner_num}.png")),
    filename: "banner-#{banner_num}.png",
    content_type: "image/png"
  )
  project.save!

  puts "  - Created project: #{project.name}"
end

puts "Projects created successfully!"
