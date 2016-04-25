FactoryGirl.define do
  factory :comment do
    text Faker::Hipster.sentence
  end
end
