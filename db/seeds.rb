# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

owner  = FactoryBot.create(:owner)
admin_user  = FactoryBot.create(
  :user,
  :admin,
  email: "admin@email.com", 
  password: 'teste1234')

owner_user  = FactoryBot.create(
  :user,
  :owner,
  owner:,
  email: "owner@email.com", 
  password:'teste1234'
)
