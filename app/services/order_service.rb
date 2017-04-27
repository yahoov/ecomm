class OrderService
  def initialize(user, items)
    @user = user
    @items = items
  end

  def create_order
    ## randomize result
    if [true, false].sample
      order_setup
    else
      false
    end
  end

  private

  attr_reader :user, :items

  def order_setup
    result = true

    begin
      order = user.orders.create!(fulfilled: false)
      items.each do |item|
        item.itemable = order
        item.save
      end
      order.fulfilled = true
      order.save
      result = order
    rescue => e
      result = false
      Rails.logger.info "*************** Order exception: #{e} ***************"
    end

    ProductService.new({}).decrement_stock(result)

    return result
  end
end
