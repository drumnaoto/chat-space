FactoryGirl.define do

  fake_password = Faker::Internet.password

  factory :user do
    name                   { Faker::Name.name }
    email                  { Faker::Internet.email }
    password               fake_password
    password_confirmation  fake_password
  end

end
