class OrderdetailsController < ApplicationController

  def new
	  
  end

  def create
    if !params[:orderdetail].nil?
      @quantity= params[:orderdetail][:Quantity]
      @product_id= params[:orderdetail][:product_id]
      edit_orderdetail(@product_id,@quantity)
    end    
  	redirect_to orderdetails_url
  end
  def index
    @categories = Category.all
  	@orderdetails =[]  	
    if !session[:product_id].nil?
      cart_info  session[:product_id]
    end
    if !session[:cart].nil?
      session[:cart].each do |item|
        @hashdetail = {}
    	  @product = Product.find(item["Product_id"])
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
    @details.delete_if { |detail| detail["Product_id"].to_f == params[:id].to_f }
    session[:cart] = @details     
    redirect_to orderdetails_url
  end
  def orderdetail_params
     params.require(:orderdetails).permit(:Quantity)
  end
end
