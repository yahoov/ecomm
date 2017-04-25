require 'rails_helper'

describe CartService do
  let(:user) { FactoryGirl.create(:user) }

  context 'with valid data and single product' do
    let(:session) { { cart: { 'products' => ['1'] } } }

    subject(:cart) do
      CartService.new(user, session[:cart]).create_or_update_cart
    end

    it 'creates the cart with a single item' do
      expect(cart).to be_a Cart
      expect(cart.items.first).to be_a Item
    end
  end

  context 'with valid data and multiple unique products' do
    let(:session) { { cart: { 'products' => ['1', '2'] } } }

    subject(:cart) do
      CartService.new(user, session[:cart]).create_or_update_cart
    end

    it 'creates multiple items in the cart of the same number as number of unique products' do
      expect(cart.items.count).to eq 2
    end
  end

  context 'with valid data and multiple unique/non-unique products' do
    let(:session) { { cart: { 'products' => ['1', '2', '1'] } } }

    subject(:cart) do
      CartService.new(user, session[:cart]).create_or_update_cart
    end

    it 'creates multiple items in the cart of the same number as number of unique products' do
      expect(cart.items.count).to eq 2
    end

    it 'sets the quantity attribute of item to the number of times each unique product is repeated in session data' do
      expect(cart.items.first.quantity).to eq 2
    end
  end

  context 'with valid data' do
    let(:session) { { cart: { 'products' => ['1'] } } }

    subject(:cart_service) do
      CartService.new(user, session[:cart])
    end

    it 'can be used to remove item from cart' do
      cart = cart_service.create_or_update_cart
      expect(cart).to be_a Cart
      expect(cart.items.count).to eq 1

      session_hash = { cart: { 'products' => session[:cart]['products'] } }
      cart = cart_service.remove_cart_item
      expect(cart).to be_a Cart
      expect(cart.items.count).to eq 0
    end
  end

  ## similarly test for other scenarios
end
