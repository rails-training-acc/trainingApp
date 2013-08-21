namespace :db do
  desc "Fill database with fake information"
  task populate: :environment do
    99.times do |n|
      name = Faker::Name.name
      email = Faker::Internet.safe_email
      password = "#{Faker::Lorem.words(2)}#{n}"
      User.create!(name: name, email: email, password: password, password_confirmation: password)
    end
  end
end
