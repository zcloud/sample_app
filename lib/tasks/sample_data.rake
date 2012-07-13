namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "User - Admin User",
                         email: "admin@test.com",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)

		99.times do |n|
      name  = Faker::Name.name
      email = "user#{n+1}@test.com"
      password  = "foobar"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
