require 'rails_helper'

RSpec.describe Product, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:product).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:product, name: nil).should_not be_valid
  end

  it "is invalid without a description" do
    FactoryGirl.build(:product, description: nil).should_not be_valid
  end

  it "is invalid without a price" do
    FactoryGirl.build(:product, price: nil).should_not be_valid
  end

  it "is invalid without a quantity" do
    FactoryGirl.build(:product, quantity: nil).should_not be_valid
  end
end
