# create admin user
admin_email = 'vinicius.venancio@test.com'
unless User.find_by_email(admin_email)
  User.create!(email: admin_email, password: '123456', role: 'admin')
end

puts "Admin user created"