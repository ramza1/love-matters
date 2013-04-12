# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.password 'p@ssword'
    f.password_confirmation 'p@ssword'
  end
end
