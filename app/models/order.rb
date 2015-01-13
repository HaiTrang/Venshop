class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_details
    
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  def self.sendmail(order)  	
  	@userinfo = {}
  	@order = order
  	@userinfo["Name"] = @order.username
  	@userinfo["PhoneNumber"] = @order.phonenumber
  	@userinfo["Email"] = @order.email
    @orderdetails = OrderDetail.show_orderdetail(order.id)
    @orderinfo = []
    @orderinfo.push(@userinfo)
    @total["Total"] = 0.0
    @orderdetails.each do |detail|
      @hashdetail = {}      
      @product = Product.find_products(detail["Product_id"])
      @hashdetail["Product"] = @product.name;
      @hashdetail["Price"] = @product.price;
      @hashdetail["Quantity"] = detail["Quantity"];
      @total["Total"] = @total["Total"] + order_total(@product.price,detail["Quantity"])
      @orderinfo.push(@hashdetail)
	  end    
    begin
	   OrderNotifier.received(@orderinfo).deliver
    rescue => e
      puts e.inspect
      puts e.backtrace
    end
    @orderinfo.push(@total["Total"])
  end

  def self.find_oder(order_id)
    return Order.find(order_id)     
  end
  def order_total(price,quantity)
    @price_tmp = price[1..price.length].to_f
    return @price_tmp * quantity
  end
end
