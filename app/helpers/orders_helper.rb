module OrdersHelper
  def sendmail(order)  	
  	@userinfo = {}
  	@order = order
  	@userinfo["Name"] = @order.username
  	@userinfo["PhoneNumber"] = @order.phonenumber
  	@userinfo["Email"] = @order.email
    @orderdetails = show_orderdetail(order.id)
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
	OrderNotifier.received(@orderinfo).deliver
  end
end
