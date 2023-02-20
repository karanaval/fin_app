# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

(1..10).each do |id|
  Category.create(
    id: id,
    name: Faker::Commerce.department(max: 1),
    description: "Category Testing Data"
  )
end

# categories_ids  = Category.select(:id).map {|id| id.attributes.values}

# for i in (1..categories_ids.length) do
#   category_id = categories_ids[i]
#   20.times do
#     Operation.create(
#       amount: Faker::Commerce.price,
#       odate: Faker::Time.between(from: DateTime.now - 30, to: DateTime.now, format: :default),
#       description: "Operation Testing Data",
#       category_id: category_id
#     )
#   end
# end

200.times do
  Operation.create(
    amount: (Faker::Number.within(range: 0.1..2000.0)).round(2),
    odate: Faker::Time.between(from: DateTime.now - 30, to: DateTime.now, format: :default),
    description: "Testing Data",
    category_id: rand(1..Category.all.length)
  )
end
