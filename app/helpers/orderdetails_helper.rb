module OrderdetailsHelper
  def edit_orderdetail(pro_id,quantity)
    @details = session[:cart]
    @details.each do |detail|
    	if detail["Product_id"].to_f == pro_id.to_f 
    		detail["Quantity"] = quantity.to_i
    		break
    	end
    end 
    session[:cart] = @details    
  end
  def show_orderdetail(order_id)
    @orderdetails = OrderDetail.where(order_id: order_id)
    return @orderdetails
  end
end
