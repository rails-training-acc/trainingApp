FactoryGirl.define do
  factory :user do
    name     "John Doe"
    email    "john@doe.com"
    password "foobaR123"
    password_confirmation "foobaR123"
  end

  factory :admin_user do
    name "John Doe Sr."
    email "john.dow@example.com"
    password "Foobar321"
    password_confirmation "Foobar321"
  end
end
