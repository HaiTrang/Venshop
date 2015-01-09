class OrdersController < ApplicationController
  include Product::Controller
  include Order::Controller
  
  before_action :find_products, only: [ :show]
  before_action :create_cart, only: [ :create]
  before_action :list_categories, only: [:new, :show, :create]
  
	def new    
    @order = Order.new    
    @user = User.find(session[:user_id])
  end
  def create  

  end
  def show

  end
end
