class ProductService
  def initialize(params)
    @product_id = params[:id]
    @name = params[:name]
    @description = params[:description]
    @price = params[:price]
    @quantity = params[:quantity]
    @maker = params[:maker]
  end

  def create_product
    product_setup
  end

  def update_product
    product_edits
  end

  def decrement_stock(order)
    refresh_stock(order)
  end

  def fetch_cart_products(user)
    products = []
    user.cart.items.each do |item|
      product = Product.find(item.product_id)
      product.quantity = item.quantity
      products << product
    end

    return products
  end

  def fetch_session_cart_products(product_ids)
    products = []
    product_ids_groups = product_ids.group_by{|x| x}.values

    product_ids_groups.each do |grouped_ids|
      product_id = grouped_ids.first
      product = Product.find(product_id)
      product.quantity = grouped_ids.count
      products << product
    end

    return products
  end

  private

  attr_reader :product_id, :name, :description, :price, :quantity, :maker

  def product_setup
    product = Product.new product_attributes
    product.save
    return product
  end

  def product_edits
    product = Product.find(product_id)
    product.update_attributes product_attributes
    return product
  end

  def refresh_stock(order)
    order.items.each do |item|
      product = Product.find(item.product_id)
      product.quantity -= item.quantity
      product.save
    end
  end

  def product_attributes
    {
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      maker: maker
    }
  end
end
