class AddDefaultUserToUsers < ActiveRecord::Migration
  def change
    User.create({name: "Janette Doe", email:"jandoe@example.com", 
                password: "Secret31", password_confirmation: "Secret31"})
    say "Created default user"
  end
end
