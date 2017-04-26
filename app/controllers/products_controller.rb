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

    if @product.persisted?
      flash[:success] = "Product has been successfully created!"
      redirect_to product_path(@product)
    else
      flash[:error] = "Unable to execute the request."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = ProductService.new(params[:product].merge(id: params[:id])).update_product

    unless @product.changed? ## is not dirty
      flash[:success] = "Product has been successfully updated!"
      redirect_to product_path(@product)
    else
      flash[:error] = "Unable to execute the request."
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

    redirect_to dashboard_path
  end
end
