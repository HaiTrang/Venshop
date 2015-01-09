class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_details
  def self.sendmail(order)  	
  	@userinfo = {}
  	@order = order
  	@userinfo["Name"] = @order.username
  	@userinfo["PhoneNumber"] = @order.phonenumber
  	@userinfo["Email"] = @order.email
    @orderdetails = OrderDetail.show_orderdetail(order.id)
    @orderinfo = []
    @orderinfo.push(@userinfo)

    @orderdetails.each do |detail|
      @hashdetail = {}
      @product = Product.find(detail["Product_id"])
      @hashdetail["Product"] = @product.name;
      @hashdetail["Price"] = @product.price;
      @hashdetail["Quantity"] = detail["Quantity"];
      @orderinfo.push(@hashdetail)
	  end
    p "xac nhan lai---------------------------------------------------------------------------------------------------------"
    p @orderinfo

    begin
	   OrderNotifier.received(@orderinfo).deliver
    rescue => e
      puts e.inspect
      puts e.backtrace
    end
  end

end
