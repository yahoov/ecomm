class HomeController < ApplicationController
  def index
    @products = Product.order("created_at DESC").limit(6)
    @last_dt = @products.any? ? @products.last.created_at : ''
    @load_more = Product.all.count > 6
  end

  def load_products
    sleep 1
    last = if params[:last_dt].blank?
      Time.now + 1.second
    else
      ActiveSupport::TimeZone['UTC'].parse(params[:last_dt])
    end

    @products = Product.where("created_at < ?", last).order("created_at DESC").limit(6)
    @last_dt = @products.empty? ? false : @products.last.created_at
  end
end
