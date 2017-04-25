require 'rails_helper'
require 'support/features/admin/session_helpers'
require 'support/features/product/product_helpers'

feature "There is a product creation form -" do
  include Features::Admin::SessionHelpers

  given!(:admin) { FactoryGirl.create(:admin) }

  scenario "Admin navigates to the product creation page where the form is displayed with expected fields" do
    sign_in admin
    click_link 'New Product'

    expect(page).to have_xpath("//form", id: "new_product")
    within(product_form) do
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Price')
      expect(page).to have_field('Quantity')
      expect(page).to have_field('Maker')
    end
  end
end

feature "Admin can create new products" do
  include Features::Admin::SessionHelpers
  include Features::Admin::ProductHelpers
  # include ActionDispatch::TestProcess

  given!(:admin) { FactoryGirl.create(:admin) }

  background do
    sign_in admin
  end

  scenario "with valid data" do
    data = {
      name: Faker::Name.unique.name,
      description: Faker::Lorem.characters(100),
      price: Faker::Number.number(3),
      quantity: Faker::Number.number(2),
      maker: Faker::Name.unique.name
    }

    create_product_with data
    expect(page).to have_content("Product has been successfully created")
    # expect(page).to have_selector("div", id: 'product-1')
    expect(page).to have_selector("div", text: data[:name])
  end
end

def product_form
  '#new_product'
end
