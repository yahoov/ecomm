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
