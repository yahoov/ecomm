class Product < ActiveRecord::Base

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true


  def self.fetch_cart_products(user)
    products = []
    user.cart.items.each do |item|
      product = Product.find(item.product_id)
      product.quantity = item.quantity
      products << product
    end

    return products
  end

  def self.fetch_session_cart_products(product_ids)
    products = []
    product_ids_groups = product_ids.group_by{|x| x}.values

    product_ids_groups.each do |grouped_ids|
      product_id = grouped_ids.first
      product = find(product_id)
      product.quantity = grouped_ids.count
      products << product
    end

    return products
  end

  def self.decrement_stock(order)
    order.items.each do |item|
      product = find(item.product_id)
      product.quantity -= item.quantity
      product.save
    end
  end
end
