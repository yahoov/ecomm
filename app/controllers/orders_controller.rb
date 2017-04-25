class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @items = current_user.cart.items
  end

  def create
    items = current_user.cart.items
    result = OrderService.new(current_user, items).create_order

    if result
      session[:cart] = {}
      session_hash = { cart: { 'products' => [] } }
      CartService.new(current_user, session_hash[:cart]).create_or_update_cart
      flash[:success] = 'Thank you! Your order has been successfully placed!'
      flash.keep(:success)
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong. Please try again in sometime.'
      flash.keep(:alert)
      redirect_to new_order_path(current_user)
    end
  end
end
