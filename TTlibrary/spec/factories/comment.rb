FactoryGirl.define do
  factory :comment do
    text Faker::Hipster.sentence
    association :book
    association :user
  end
end
