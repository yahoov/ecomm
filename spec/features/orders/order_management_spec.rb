require 'rails_helper'
require 'support/features/admin/session_helpers'
require 'support/features/product/product_helpers'
require 'support/features/user/session_helpers'

feature "User can place order" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "with products in cart" do
    admin_sign_in admin
    expect(page).to have_content "Signed in successfully"
    data = {
      name: Faker::Name.unique.name,
      description: Faker::Lorem.characters(100),
      price: Faker::Number.number(3),
      quantity: Faker::Number.number(2),
      maker: Faker::Name.unique.name
    }

    create_product_with data
    expect(page).to have_content("Product has been successfully created")
    click_link 'Sign Out'

    user_sign_in user
    expect(page).to have_selector("div", text: data[:name])
    all('a', :text => 'Add to cart').first.click
    expect(page).to have_content("My Cart (1)")
    click_link 'My Cart (1)'
    click_link 'Proceed to checkout'
    expect(page).to have_content("Confirm Order")
    click_link 'alias_to_make_payment'
    expect(page).to have_content("Your order has been successfully placed!")
  end
end

feature "Order summary is displayed to the user after successfully placing order" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "with products in cart" do
    admin_sign_in admin
    expect(page).to have_content "Signed in successfully"
    data = {
      name: Faker::Name.unique.name,
      description: Faker::Lorem.characters(100),
      price: Faker::Number.number(3),
      quantity: Faker::Number.number(2),
      maker: Faker::Name.unique.name
    }

    create_product_with data
    expect(page).to have_content("Product has been successfully created")
    click_link 'Sign Out'

    user_sign_in user
    expect(page).to have_selector("div", text: data[:name])
    all('a', :text => 'Add to cart').first.click
    expect(page).to have_content("My Cart (1)")
    click_link 'My Cart (1)'
    click_link 'Proceed to checkout'
    expect(page).to have_content("Confirm Order")
    click_link 'alias_to_make_payment'
    within('div.order_summary') do
      expect(page).to have_selector("a", text: data[:name])
      expect(page).to have_selector("td", text: '1')
      expect(page).to have_selector("td", text: data[:price])
      expect(page).to have_selector("td", text: "#{1 * data[:price].to_f}")
    end
  end
end

feature "Product count decreases after making payment for an order" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "with products in cart" do
    admin_sign_in admin
    expect(page).to have_content "Signed in successfully"
    data = {
      name: Faker::Name.unique.name,
      description: Faker::Lorem.characters(100),
      price: Faker::Number.number(2),
      quantity: 112,
      maker: Faker::Name.unique.name
    }

    create_product_with data
    expect(page).to have_content("Product has been successfully created")
    click_link 'Sign Out'

    user_sign_in user
    expect(page).to have_selector("div", text: data[:name])
    all('a', :text => 'Add to cart').first.click
    expect(page).to have_content("My Cart (1)")
    click_link 'My Cart (1)'
    click_link 'Proceed to checkout'
    expect(page).to have_content("Confirm Order")
    click_link 'alias_to_make_payment'
    visit '/'
    click_link data[:name]
    expect(page).to have_content("111") ## 1 less than original quantity/stock
  end
end
