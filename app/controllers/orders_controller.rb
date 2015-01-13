class OrdersController < ApplicationController
  include Product::Controller
  include Order::Controller

  before_action :list_categories, only: [:new, :show, :create]
  
	def new    
    @order = Order.new()    
    if  logged_in?
      @user = User.find_user(session[:user_id])
    else
      @user = User.new()
    end
    
  end
  def create  
    create_cart
  end
  def show
    find_products    
  end
  
end
