FactoryGirl.define do

  factory :message do
    body             { Faker::Lorem.sentence }
    image            Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/images/neko.jpg"))
    user
    group
  end

end
