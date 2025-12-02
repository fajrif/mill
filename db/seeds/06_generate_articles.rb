# CREATE Articles
Article.delete_all

puts "Creating articles..."

categories = Category.all

3.times do |i|
  article = Article.new(
    title: Faker::Lorem.unique.sentence(word_count: 6),
    short_description: Faker::Lorem.sentence(word_count: 20),
    category: categories.sample,
    published_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    status: [0, 1].sample, # 0: draft, 1: published
    video_url: ["", Faker::Internet.url(host: 'youtube.com')].sample
  )

  # Attach image
  article.image.attach(
    io: File.open(Rails.root.join("vendor/assets/images/articles/article-#{i + 1}.png")),
    filename: "article-#{i + 1}.png",
    content_type: "image/png"
  )

  # Save article first to get ID for rich text content
  article.save!

  # Add rich text content
  article.content = ActionText::Content.new(
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

  article.save!

  puts "  - Created article: #{article.title}"
end

puts "Articles created successfully!"
