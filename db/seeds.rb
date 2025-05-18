# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product
    .create_with(name: "Red Widget", price: 32.95)
    .find_or_create_by(code: "R01")
Product
    .create_with(name: "Green Widget", price: 24.95)
    .find_or_create_by(code: "G01")
Product
    .create_with(name: "Blue Widget", price: 7.95)
    .find_or_create_by(code: "B01")

DeliveryCost
    .create_with(price: 4.95)
    .find_or_create_by(threshold: 0)
DeliveryCost
    .create_with(price: 2.95)
    .find_or_create_by(threshold: 50)
DeliveryCost
    .create_with(price: 0)
    .find_or_create_by(threshold: 90)
