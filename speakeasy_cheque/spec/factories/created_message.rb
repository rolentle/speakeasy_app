FactoryGirl.define do
  factory :created_message do
    sequence(:created_at) { |n| DateTime.now - n }
    sequence(:sid) { |n| "#{n}" }
  end
end
