FactoryGirl.define do
  factory :book do
    title Faker::Book.title
    year Faker::Number.between(0, 2016)
    ISBN Faker::Number.number(2)
    author_id Faker::Number.number(2)
  end
end
