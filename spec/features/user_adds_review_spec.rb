require 'rails_helper'

feature "User adds review for beer" do

  scenario 'authenticated user creates review for a beer' do
    review = FactoryGirl.build(:review)
    user = review.user
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "here"
    visit beer_path(review.beer)
    fill_in "Text", with: review.text
    select review.taste.to_i, from: "Taste"
    click_on "Submit"
    expect(page).to have_content("Review created successfully")
  end

end
