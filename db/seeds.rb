# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
account = Account.find_or_create_by!(name: "OpenDesk Demo")

admin = User.find_or_initialize_by(
  email_address: "admin@opendesk.local"
)

admin.account = account
admin.role = :admin
admin.password = "password123"
admin.password_confirmation = "password123"
admin.save!

puts "Created #{account.name}"
puts "Login: #{admin.email_address}"


customer = User.find_or_initialize_by(
  email_address: "customer@opendesk.local"
)

customer.account = account
customer.role = :customer
customer.password = "password123"
customer.password_confirmation = "password123"
customer.save!

puts "Created #{account.name}"
puts "Login: #{customer.email_address}"
