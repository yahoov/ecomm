require 'rails_helper'
require 'support/features/user/session_helpers'

feature "There is a User login form - " do
  scenario "Visitor navigates to the Admin login page where the form is displayed with expected fields" do
    visit "/users/sign_in"
    expect(page).to have_xpath("//form", id: "new_user_session")
    within(login_form) do
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Remember me')
    end
  end
end

feature 'Visitor logins as User' do
  include Features::User::SessionHelpers

  given!(:user) { FactoryGirl.create(:user) }
  given!(:invalid_user) { FactoryGirl.build(:user) }

  scenario 'with valid account' do
    sign_in user
    expect(page).to have_content "Signed in successfully"
  end

  scenario 'with invalid account' do
    sign_in invalid_user
    expect(page).to have_content "Invalid Email or password"
  end

  ## similarly add tests for other scenarios
end

feature 'Visitor is redirected to home page' do
  include Features::User::SessionHelpers

  given!(:user) { FactoryGirl.create(:user) }

  scenario 'after logging in as User' do
    sign_in user
    expect(current_path).to eq "/"
  end
end

def login_form
  '#new_user_session'
end
