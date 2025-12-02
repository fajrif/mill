# CREATE Events
Event.delete_all

puts "Creating events..."

categories = Category.all

2.times do |i|
  event = Event.new(
    title: Faker::Lorem.unique.sentence(word_count: 6),
    short_description: Faker::Lorem.sentence(word_count: 20),
    category_id: categories.sample.id,
    published_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
    status: [0, 1].sample, # 0: draft, 1: published
    video_url: ["", Faker::Internet.url(host: 'youtube.com')].sample
  )

  # Attach image
  event.image.attach(
    io: File.open(Rails.root.join("vendor/assets/images/events/event-#{i + 1}.png")),
    filename: "event-#{i + 1}.png",
    content_type: "image/png"
  )

  # Save event first to get ID for rich text content
  event.save!

  # Add rich text content
  event.content = ActionText::Content.new(
    "<h2>#{Faker::Lorem.sentence}</h2>" \
    "<p>#{Faker::Lorem.paragraph(sentence_count: 8)}</p>" \
    "<h3>#{Faker::Lorem.sentence}</h3>" \
    "<p>#{Faker::Lorem.paragraph(sentence_count: 6)}</p>" \
    "<ul>" \
    "<li>#{Faker::Lorem.sentence}</li>" \
    "<li>#{Faker::Lorem.sentence}</li>" \
    "<li>#{Faker::Lorem.sentence}</li>" \
    "</ul>" \
    "<p>#{Faker::Lorem.paragraph(sentence_count: 5)}</p>"
  )

  event.save!

  puts "  - Created event: #{event.title}"
end

puts "Events created successfully!"
