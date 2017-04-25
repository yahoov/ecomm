require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:cart).should be_valid
  end

  it "belongs to a user" do
    t = User.reflect_on_association(:cart)
    t.macro.should == :has_one
  end

  it "has many items" do
    t = Cart.reflect_on_association(:items)
    t.macro.should == :has_many
  end
end
