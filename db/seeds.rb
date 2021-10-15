@user = User.create!(
  name: 'admin1',
  email: 'admin1@example.com',
  password: 'admin1@example.com',
  password_confirmation:"admin1@example.com",
  admin: true
)


# User.create!(
#   name: 'admin2',
#   email: 'admin2@example.com',
#   password: 'admin2@example.com',
#   password_confirmation:"admin2@example.com",
#   admin: true
# )

# User.create!(
#   name: 'user1',
#   email: 'user1@example.com',
#   password: 'user1@example.com',
#   password_confirmation:"user1@example.com",
#   admin: false
# )


10.times do |num|
  User.create!(
  name: "name#{num}",
  email: "email#{num}@example.com",
  password: 'password',
  password_confirmation:'password',
  admin: false
)
end

10.times do |num|
  Label.create!(name:"label#{num}")
end

10.times do |num|
  Task.create!(
    name: "task#{num}",
    content: "content#{num}",
    limit: DateTime.now + 10,
    status: rand(0..2),
    priority: rand(0..2),
    user_id: @user.id
  )
end
