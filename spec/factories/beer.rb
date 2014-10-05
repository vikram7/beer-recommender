FactoryGirl.define do
  factory :beer do
    name "Heady Topper"
    sequence :beer_id do |n|
      "#{n}"
    end

    association :brewer
    association :style
  end
end

