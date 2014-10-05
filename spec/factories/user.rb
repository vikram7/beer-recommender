FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "example#{n}@example.com"
    end

    sequence :profile_name do |n|
      "blink_user#{n}"
    end

    password "passwordpassword"
    created_at Time.now

  end
end

