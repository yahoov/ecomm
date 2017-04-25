module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"   # Green
    when "error"
      "alert-danger"    # Red
    when "alert"
      "alert-warning"   # Yellow
    when "notice"
      "alert-info"      # Blue
    else
      flash_type.to_s
    end
  end

  def grand_total(items)
    grand_total = 0

    if items.first.class.name == 'Item'
      items.each do |item|
        product = Product.find(item.product_id)
        grand_total += (product.price * item.quantity.to_i)
      end
    else
      items.each do |item|
        grand_total += (item.price * item.quantity.to_i)
      end
    end

    return grand_total
  end
end
