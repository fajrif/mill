# CREATE Category
Category.delete_all

puts "create categories"

# Category
Category.delete_all
["Italian Design", "European Signature", "Soft Steel"].each do |name|
	Category.create!(name: name)
end
