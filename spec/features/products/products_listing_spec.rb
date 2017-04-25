require 'rails_helper'
require 'support/features/admin/session_helpers'
require 'support/features/product/product_helpers'

feature "Products listing -" do
  include Features::Admin::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }

  scenario "Diplay available products when a user visits home page" do
    sign_in admin

    data = {
      name: Faker::Name.unique.name,
      description: Faker::Lorem.characters(100),
      price: Faker::Number.number(3),
      quantity: Faker::Number.number(2),
      maker: Faker::Name.unique.name
    }

    create_product_with data
    click_link 'Sign Out'

    visit "/"
    expect(page).to have_selector("div", text: data[:name])
  end
end
