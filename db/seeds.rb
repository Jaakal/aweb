# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(0...20).each do
  @user = User.new
  @user.username = Faker::Name.first_name
  @user.full_name = @user.username + " #{Faker::Name.last_name}"
  @user.photo = Faker::Avatar.image(slug: @user.username, size: "100x100", format: "jpg")
  @user.cover_image = Faker::LoremFlickr.image(size: "1760x590", search_terms: ['nature'])
  @user.save
end
