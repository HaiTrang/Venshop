module Order::Controller
  extend ActiveSupport::Concern

  def find_products
  	@order = Order.find(params[:id])
  	@orderdetails = OrderDetail.show_orderdetail(params[:id])
  	@products = []
  	@orderdetails.each do |detail|        
      @hashdetail = {}
      @product = Product.find(detail["Product_id"])
      @hashdetail["Product"] = @product;
      @hashdetail["Quantity"] = detail["Quantity"];      
      @products.push(@hashdetail)
    end
  end

  def create_cart
    #Se tao transaction o day nua
    @order = Order.new(order_params)
    @order.User_id = session[:user_id]
    @order.OrderStatus = "Waiting for confirm "       
        
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
        begin
          Order.sendmail(@order)
        rescue => e
          puts e.inspect
          puts e.backtrace
        end
        redirect_to order_path(id: @order.id )
      else  
        redirect_to root_url
      end
    end
 end
 private
   def order_params
     params.require(:order).permit(:username, :email, :phonenumber, :ShippingAddress)
   end

  
end