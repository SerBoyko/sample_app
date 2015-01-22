FactoryGirl.define do
  factory :user do
    name     "Hanter"
    email    "hanter@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end