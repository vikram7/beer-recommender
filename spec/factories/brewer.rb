FactoryGirl.define do
  factory :brewer do
    name "The Alchemist"
    sequence :brewer_id do |n|
      "#{n}"
    end
  end
end

