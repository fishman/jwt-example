# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

User.create(name: "some name", email: "test@test.com", password: "123456")
