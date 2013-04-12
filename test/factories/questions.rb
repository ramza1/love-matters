# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do |f|
    f.name 'John Doe'
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.website  "www.facebook.com/my_page"
    f.question "My shiny lovely love question has just been posted pls check it out"
    f.answer "brave answer"
  end
end
