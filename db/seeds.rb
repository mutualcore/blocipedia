require 'faker'

10.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end 
users = User.all

50.times do |variable|
  Wiki.create!(
    title:    Faker::Lorem.sentence,
    body:     Faker::Lorem.paragraph,
    user:     users.sample
    )
end

wikis = Wiki.all

admin = User.new(
  name: 'Admin User', 
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin')
admin.skip_confirmation!
admin.save!

moderator = User.new(
  name: 'premium User',
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium')
moderator.skip_confirmation!
moderator.save!

member = User.new(
  name: 'Standard User',
  email: 'standard@example.com',
  password: 'helloworld',
  role: 'standard')
member.skip_confirmation!
member.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"