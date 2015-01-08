class OrdersController < ApplicationController
  
	def new    
   @order = Order.new
   @categories = Category.all
  end
  def create
    @categories = Category.all
    #Se tao transaction o day nua
    @order = Order.new(order_params)
    @order.User_id = session[:user_id]
    @order.OrderStatus = "Waiting for confirm "
        # puts "truoc khi guiiiiiiiiiiiiiiii"
        # puts @order.username
        # puts @order.phonenumber
        # puts @order.User_id
        # puts @order.OrderStatus
        # puts session[:user_id]
        
    if !session[:cart].nil?
      if @order.save        
        session[:cart].each do |item|
          @orderdetail = OrderDetail.new
          @orderdetail.Product_id = item["Product_id"]          
          @orderdetail.Order_id = @order.id
          @orderdetail.Quantity = item["Quantity"]          
          @orderdetail.save
        end
        delete_cart

        sendmail(@order)

        redirect_to order_path(id: @order.id )
      else
  #     render 'new'      
        redirect_to root_url
      end
    end
  end
def show    
  @categories = Category.all
  @order = Order.find(params[:id])
  @orderdetails = show_orderdetail(params[:id])
  @products = []
  @orderdetails.each do |detail|        
      @hashdetail = {}
      @product = Product.find(detail["Product_id"])
      @hashdetail["Product"] = @product;
      @hashdetail["Quantity"] = detail["Quantity"];
      
      @products.push(@hashdetail)
  end

end

private

  def order_params
     params.require(:order).permit(:username, :email, :phonenumber, :ShippingAddress)
  end

end
