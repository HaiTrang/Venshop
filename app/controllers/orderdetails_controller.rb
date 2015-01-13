class OrderdetailsController < ApplicationController
  include Product::Controller
  before_action :list_categories, only: [:index]

  def new
	  
  end

  def create
    if !params[:orderdetail].nil?
      @quantity = params[:orderdetail][:Quantity]
      @product_id = params[:orderdetail][:product_id]      
      session[:cart] = OrderDetail.edit_orderdetail(@product_id,@quantity,session[:cart])
    end    
  	redirect_to orderdetails_url
  end

  def index    
  	@orderdetails =[]  	
    if !session[:product_id].nil?
      cart_info  session[:product_id]
    end
    if !session[:cart].nil?
      session[:cart].each do |item|
        @hashdetail = {}
    	  @product = Product.find_products(item["Product_id"])
    	  @hashdetail["Product"] = @product;
    	  @hashdetail["Quantity"] = item["Quantity"];    	  
    	  @orderdetails.push(@hashdetail)
      end
    end
  end  

  def edit
     redirect_to orderdetails_url
  end

  def update
    redirect_to orderdetails_url
  end
  def delete_all_cart    
    session.delete(:cart)
    redirect_to orderdetails_url
  end
  
  def destroy
    @details = session[:cart]
    OrderDetail.delete_orderdetail(@details,params[:id])
    session[:cart] = @details     
    redirect_to orderdetails_url
  end
  def orderdetail_params
     params.require(:orderdetails).permit(:Quantity)
  end
end
