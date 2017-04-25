require 'rails_helper'
require 'support/features/admin/session_helpers'

feature "There is a Admin login form - " do
  scenario "Visitor navigates to the Admin login page where the form is displayed with expected fields" do
    visit "/admins/sign_in"
    expect(page).to have_xpath("//form", id: "new_admin_session")
    within(admin_login_form) do
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Remember me')
    end
  end
end

feature 'Visitor logins as Admin' do
  include Features::Admin::SessionHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:invalid_admin) { FactoryGirl.build(:admin) }

  scenario 'with valid account' do
    sign_in admin
    expect(page).to have_content "Signed in successfully"
  end

  scenario 'with invalid account' do
    sign_in invalid_admin
    expect(page).to have_content "Invalid Email or password"
  end

  ## similarly add tests for other scenarios
end

feature 'Visitor is redirected to dashboard' do
  include Features::Admin::SessionHelpers

  given!(:admin) { FactoryGirl.create(:admin) }

  scenario 'after logging in as Admin' do
    sign_in admin
    expect(current_path).to eq "/admins/dashboard"
  end
end

def admin_login_form
  '#new_admin_session'
end
