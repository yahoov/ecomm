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

    subject(:product) do
      ProductService.new(params[:product]).create_product
    end

    it 'creates the product' do
      expect(product).to be_a Product
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

    subject(:product) do
      ProductService.new(params[:product]).create_product
    end

    it 'does not creates the product' do
      expect(product).to be false
    end
  end

  ## similarly test for other scenarios
end
