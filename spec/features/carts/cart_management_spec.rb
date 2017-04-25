require 'rails_helper'
require 'support/features/admin/session_helpers'
require 'support/features/product/product_helpers'
require 'support/features/user/session_helpers'

feature "Visitor can add products to cart" do
  include Features::Admin::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }

  scenario "when there are products available" do
    sign_in admin
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

    visit '/'
    expect(page).to have_selector("div", text: data[:name])
    all('a', :text => 'Add to cart').first.click
    expect(page).to have_content("My Cart (1)")
  end
end

feature "Visitor cannot add products to cart" do
  include Features::Admin::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }

  scenario "when product is out of stock" do
    sign_in admin
    data = {
      name: Faker::Name.unique.name,
      description: Faker::Lorem.characters(100),
      price: Faker::Number.number(3),
      quantity: 0,
      maker: Faker::Name.unique.name
    }

    create_product_with data
    expect(page).to have_content("Product has been successfully created")
    click_link 'Sign Out'

    visit '/'
    expect(page).to have_selector("div", text: data[:name])
    # expect(page).to_not have_link("Add to cart") ## link is being created from other tests
    expect(page).to have_content("Out of stock")
  end
end

feature "User can add products to cart" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "when there are products available" do
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
  end
end

feature "Products persist in cart" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "when user logins again" do
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
    expect(page).to have_content 'Product successfully added to cart'
    click_link 'Sign Out'
    user_sign_in user
    expect(page).to have_content("My Cart (1)")
  end
end

feature "User can check items in their cart" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "when there are items in it" do
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
    within('tr.cart_item') do
      expect(page).to have_selector("a", text: data[:name])
      expect(page).to have_selector("a", text: 'Remove from cart')
    end
  end
end

feature "User can remove products from cart" do
  include Features::Admin::SessionHelpers
  include Features::User::SessionHelpers
  include Features::Admin::ProductHelpers

  given!(:admin) { FactoryGirl.create(:admin) }
  given!(:user) { FactoryGirl.create(:user) }

  scenario "when signed in" do
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
    click_link 'Remove from cart'
    expect(page).to have_content("Item removed from cart")
    expect(page).to_not have_content(data[:name])
    expect(page).to_not have_selector("a", text: data[:name])
  end

  scenario "when not signed in" do
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

    visit '/'
    all('a', :text => 'Add to cart').first.click
    expect(page).to have_content("My Cart (1)")
    click_link 'My Cart (1)'
    click_link 'Remove from cart'
    expect(page).to have_content("Item removed from cart")
    expect(page).to_not have_content(data[:name])
    expect(page).to_not have_selector("a", text: data[:name])
  end
end
