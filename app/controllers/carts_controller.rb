class CartsController < ApplicationController
  # before_action :authenticate_user!, only: [:show]

  def show
    @products = []

    if user_signed_in?
      @products = ProductService.new({}).fetch_cart_products(current_user)
    else
      @products = ProductService.new({}).fetch_session_cart_products(session[:cart]['products'])
    end
  end

  def create
    ## create session for cart, if does not exists
    session[:cart] ||= {}
    products = session[:cart]['products']

    ## if exists, add new, else create new variable
    if products.present?
      session[:cart]['products'] << params[:product_id]
    else
      session[:cart]['products'] = Array(params[:product_id])
    end

    res = true
    if user_signed_in?
      ## persist to DB
      res = CartService.new(current_user, session[:cart]).create_or_update_cart
    end

    if res
      flash[:success] = 'Product successfully added to cart!'
    else
      flash[:alert] = 'Unable to add to cart. Please try again in sometime.'
    end

    flash.keep
    redirect_to request.referer
  end

  def remove_item
    product_id = params[:product_id]
    session[:cart]['products'].delete product_id

    res = true
    if user_signed_in?
      ## remove from DB
      session_hash = { cart: { 'products' => [product_id] } }
      res = CartService.new(current_user, session_hash[:cart]).remove_cart_item
    end

    if res
      flash[:success] = 'Item removed from cart!'
    else
      flash[:alert] = 'Unable to remove item from cart. Please try again in sometime.'
    end

    flash.keep
    redirect_to request.referer
  end
end
