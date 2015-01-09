class OrderDetail < ActiveRecord::Base
  belongs_to :order
  has_one :product
  def self.delete_orderdetail(details,product_id)
	details.delete_if { |detail| detail["Product_id"].to_f == product_id.to_f }  	
  end

  def self.edit_orderdetail(pro_id,quantity,session_cart)
    @details = session_cart
    @details.each do |detail|
    	if detail["Product_id"].to_f == pro_id.to_f 
    		detail["Quantity"] = quantity.to_i
    		break
    	end
    end 
    return @details    
  end
  def self.show_orderdetail(order_id)
    @orderdetails = OrderDetail.where(order_id: order_id)
    return @orderdetails
  end
end
