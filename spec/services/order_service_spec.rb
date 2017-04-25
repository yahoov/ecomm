require 'rails_helper'

describe OrderService do
  let(:user) { FactoryGirl.create(:user) }

  context 'with valid data' do
    let(:item) { FactoryGirl.create(:item) }

    subject(:order) do
      OrderService.new(user, [item]).create_order
    end

    it 'creates the order with products as items' do
      expect(order).to be_a Order
      expect(order.items.first).to be_a Item
    end
  end

  ## similarly test for other scenarios
end
