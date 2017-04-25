class Item < ActiveRecord::Base
  belongs_to :itemable, :polymorphic => true

  validates :product_id, presence: true
  validates :quantity, presence: true
end
