require 'faker'

FactoryGirl.define do
  factory :url do
    url { Faker::Internet.url }
    access 0

    trait :accessed do
      access { Faker::Number.between(1, 100) }
    end

    trait :accessed_once do
      access 1
    end
  end
end
