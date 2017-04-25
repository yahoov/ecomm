class CartService
  def initialize(user, cart_session)
    @user = user
    @product_ids = cart_session['products']
  end

  def create_or_update_cart
    cart_setup
  end

  def remove_cart_item
    remove_from_cart
  end

  attr_reader :user, :product_ids

  private

  # attr_reader :user, :product_ids

  def cart_setup
    cart = user.cart || user.build_cart
    product_ids_groups = product_ids.group_by{|x| x}.values

    product_ids_groups.each do |grouped_ids|
      product_id = grouped_ids.first
      ## do not create new item if it already exists with the given product id
      item = cart.items.find_by(product_id: product_id) || cart.items.new
      item.product_id = product_id
      item.quantity = grouped_ids.count
      item.save
    end

    if cart.save
      return cart
    else
      return false
    end
  end

  def remove_from_cart
    cart = user.cart
    product_id = product_ids.first
    item = cart.items.find_by(product_id: product_id)
    item.destroy if item

    if cart.save
      return cart
    else
      return false
    end
  end
end
