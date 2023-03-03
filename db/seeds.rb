# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

15.times do |id|
  Category.create(
    id: id,
    name: Faker::Commerce.department(max: 1),
    description: "Category Testing Data"
  )
end

200.times do
  Operation.create(
    amount: Faker::Commerce.price(range: 0..5000.00),
    odate: Faker::Date.between(from: Date.today - 90, to: Date.today),
    description: "Category Testing Data",
    category_id: Category.pluck(:id).sample
  )
end


# # Generating for fixtures
# 1.upto(15) do |id|
#   puts(
#     "fix_#{id}:",
#     "  name: #{Faker::Commerce.department(max: 1)}",
#     "  description: Category #{id} Testing Data"
#     )
#   puts
# end

# 1.upto(200) do |id|
#   puts(
#     "fix_#{id}:",
#     "  amount: #{Faker::Commerce.price(range: 0..5000.00)}",
#     "  odate: #{Faker::Commerce.price(range: 0..5000.00)}",
#     "  description: Operation #{id} Testing Data",
#     "  category: fix_#{rand(1..15)}"
#     )
#   puts
# end
