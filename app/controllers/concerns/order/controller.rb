module Order::Controller
  extend ActiveSupport::Concern

  def find_products
  	 @order = Order.find_oder(params[:id])
  	@orderdetails = OrderDetail.show_orderdetail(params[:id])
  	@products = []    
    @total = 0.0
  	@orderdetails.each do |detail|        
      @hashdetail = {}
      @product = Product.find_products(detail["Product_id"])
      @hashdetail["Product"] = @product;
      @hashdetail["Quantity"] = detail["Quantity"];
      @total= @total+ order_total(@product.price,detail["Quantity"])      
      @products.push(@hashdetail)
    end    
    # @products.push(@total)    
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
          @categories = Category.all_category          
          @user = User.find_user(session[:user_id])     
          @user.email = order_params[:email]
          render 'new'         
      end
    end
 end  
  
  def order_total(price,quantity)
    @price_tmp = price[1..price.length].to_f
    return @price_tmp * quantity
  end

 private
   def order_params
     params.require(:order).permit(:username, :email, :phonenumber, :ShippingAddress)
   end

  
end