require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:item).should be_valid
  end

  it "belongs to a cart" do
    t = Cart.reflect_on_association(:items)
    t.macro.should == :has_many
  end

  it "is invalid without product id" do
    FactoryGirl.build(:item, product_id: nil).should_not be_valid
  end

  it "is invalid without quantity" do
    FactoryGirl.build(:item, quantity: nil).should_not be_valid
  end
end
