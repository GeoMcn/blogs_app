# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['customer', 'banned', 'restaurant owner', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

['dublin', 'cork', 'belfast', 'wexford'].each do |region|
  Region.find_or_create_by({name: region})
end

['thai', 'italian', 'sushi'].each do |cuisine|
  Cuisine.find_or_create_by({name: cuisine})
end

