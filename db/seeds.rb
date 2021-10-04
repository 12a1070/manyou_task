User.create!(
  name: 'admin1',
  email: 'admin1@example.com',
  password: 'test1',
  password_confirmation:"test1",
  admin: true
)


User.create!(
  name: 'admin2',
  email: 'admin2@example.com',
  password: 'test2',
  password_confirmation:"test2",
  admin: true
)

User.create!(
  name: 'user1',
  email: 'user1@example.com',
  password: 'test3',
  password_confirmation:"test3",
  admin: false
)
