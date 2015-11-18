require 'faker'

standard = User.new(
name:  'Standard User',
email: 'standard@example.com',
password: 'password',
role: 'standard'
)
standard.skip_confirmation!
standard.save!

premium = User.new(
name:  'Premium User',
email: 'premium@example.com',
password: 'password',
role: 'premium'
)
premium.skip_confirmation!
premium.save!

admin = User.new(
name:  'Admin User',
email: 'admin@example.com',
password: 'password',
role: 'admin'
)
admin.skip_confirmation!
admin.save!

50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence(1, true),
    body: Faker::Lorem.paragraph(10, true, 5)
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
