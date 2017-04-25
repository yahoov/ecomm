class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, :if => :devise_controller?
  before_action :set_cart_session

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end

  def after_sign_in_path_for(resource)
    if resource.class.to_s == "User"
      ## persist cart data in session to DB
      CartService.new(current_user, session[:cart]).create_or_update_cart
      root_path
    elsif resource.class.to_s == "Admin"
      dashboard_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.to_s == "user"
      root_path
    elsif resource_or_scope.to_s == "admin"
      new_admin_session_path
    end
  end

  def set_cart_session
    unless session[:cart].present?
      session[:cart] ||= {}
      products = session[:cart]['products']
      session[:cart]['products'] = [] if products.nil?
    end

    @count_of_cart_items = session[:cart]['products'].group_by{|x| x}.values.count

    if user_signed_in?
      @count_of_cart_items = current_user.cart.present? ? current_user.cart.items.count : 0
    end
  end
end
