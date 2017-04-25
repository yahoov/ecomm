require 'rails_helper'
require 'support/features/admin/session_helpers'

feature "There is a Admin account registration form -" do

  scenario "Visitor navigates to the Admin account registration page where the form is displayed with expected fields" do
    visit "/admins/sign_in"
    click_link "Admin Registration"
    expect(page).to have_xpath("//form", id: "new_admin_registration")
    within(admin_registration_form) do
      expect(page).to have_field('First Name')
      expect(page).to have_field('Last Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Password confirmation')
    end
  end
end

feature 'Visitor registers account as Admin' do
  include Features::Admin::SessionHelpers

  given!(:admin) { FactoryGirl.build(:admin) }

  scenario 'with valid email and password' do
    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }

    sign_up_with form_data

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario 'with invalid email' do
    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: 'invalid_email',
      password: Faker::Internet.password
    }

    sign_up_with form_data

    expect(page).to have_content('Email is invalid')
  end

  scenario 'with blank password' do
    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: ''
    }

    sign_up_with form_data

    expect(page).to have_content('Password can\'t be blank')
  end

  ## similarly add tests for other scenarios
end

def admin_registration_form
  '#new_admin_registration'
end
