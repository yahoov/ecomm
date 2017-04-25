class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:order_id])
  end

  def new
    @items = current_user.cart.items
  end

  def create
    items = current_user.cart.items
    order = OrderService.new(current_user, items).create_order

    if order
      session[:cart] = {}
      session_hash = { cart: { 'products' => [] } }
      CartService.new(current_user, session_hash[:cart]).create_or_update_cart
      # flash[:success] = 'Thank you! Your order has been successfully placed!'
      # flash.keep(:success)
      redirect_to order_summary_path(order_id: order.id)
    else
      flash[:error] = 'Something went wrong. Please try again in sometime.'
      flash.keep(:error)
      redirect_to new_order_path(current_user)
    end
  end
end
