FactoryGirl.define do
  factory :review do
    text "what a great beer"
    taste 5

    association :user
    association :beer
  end
end

