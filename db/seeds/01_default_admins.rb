# Create Default Administrator

Admin.delete_all
puts "create administrator"
Admin.create(:full_name => "Administrator", :email => "admin@mill.co.id", :password => "Secret1234!", :password_confirmation => "Secret1234!")
