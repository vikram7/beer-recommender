require 'rails_helper'

feature "User registration, sign in and sign out" do

  scenario "user signs up with correct credentials" do
    user = FactoryGirl.build(:user)
    visit root_path
    click_on "Sign up"
    save_and_open_page
    fill_in "Email", with: user.email
    fill_in "Profile name", with: user.profile_name
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_on "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "user signs in with correct credentials" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "user signs out" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "Sign out"
    expect(page).to have_content("Signed out successfully.")
  end

end
