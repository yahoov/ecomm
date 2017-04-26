require 'rails_helper'

describe ProductService do
  context 'with valid data' do
    let(:params) { { product: {
        name: Faker::Name.unique.name,
        description: Faker::Lorem.characters(100),
        price: Faker::Number.number(3),
        quantity: Faker::Number.number(2),
        maker: Faker::Name.unique.name
      } }
    }

    it 'creates the product' do
      before_count = Product.count
      product = ProductService.new(params[:product]).create_product
      expect(product).to be_a Product
      expect(Product.count).to be > before_count
    end
  end

  context 'with invalid data' do
    let(:params) { { product: {
        name: '',
        description: Faker::Lorem.characters(100),
        price: Faker::Number.number(3),
        quantity: Faker::Number.number(2),
        maker: Faker::Name.unique.name
      } }
    }

    it 'does not creates the product' do
      before_count = Product.count
      product = ProductService.new(params[:product]).create_product
      expect(product).to be_a Product
      expect(Product.count).to eq(before_count)
    end
  end

  ## similarly test for other scenarios
end
