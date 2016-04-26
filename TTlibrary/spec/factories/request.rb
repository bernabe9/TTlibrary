FactoryGirl.define do
  factory :request do
    association :book
    association :user
  end
end
