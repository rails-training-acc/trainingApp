class MakeDefaultUserAdmin < ActiveRecord::Migration
  def up
    u1 = User.find_by_email("jandoe@example.com")
    u1.update_attribute(:admin, true)
    say "Updated #{u1.email} user to admin"
    User.create({name: "Simple User", email:"simpleuser@example.com", 
                password: "Secret31", password_confirmation: "Secret31"})
    say "Created non-admin user"
  end

  def down
    u1 = User.find_by_email("jandoe@example.com")
    u1.update_attribute(:admin, false)
    say "Revoke admin rights from #{u1.email} user"
    User.find_by_email("simpleuser@example.com").delete
  end
end
