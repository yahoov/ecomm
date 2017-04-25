class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :delete]

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = ProductService.new(params[:product]).create_product

    if @product
      flash[:success] = "Product has been successfully created!"
      redirect_to product_path(@product)
    else
      if @product.errors.full_messages.any?
        flash[:error] = "Form validation errors!"
      else
        flash[:alert] = "Unable to execute the request, please try in sometime."
      end
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = ProductService.new(params[:product].merge(id: params[:id])).update_product

    if @product
      flash[:success] = "Product has been successfully updated!"
      redirect_to product_path(@product)
    else
      flash[:alert] = "Unable to execute the request, please try again."
      render 'edit'
    end
  end

  def destroy
    product = Product.find(params[:id])

    if product.destroy
      flash[:success] = "Product successfully deleted!"
    else
      flash[:alert] = "Unable to execute the request, please try in sometime."
    end

    redirect_to request.referer
  end
end
