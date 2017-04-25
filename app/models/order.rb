class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, as: :itemable, dependent: :destroy, autosave: true
end
