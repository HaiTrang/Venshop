module SessionsHelper
  # Logs in the given user.
  def log_in(user)

    session[:user_id] = user.id
    session[:user_name] = user.name
  end
  def current_user    
    @current_user ||= User.find_by(id: session[:user_id])
    # @current_user ||= User.findby_user("id", session[:user_id])
    
  end
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  # Logs out the current user.
  def log_out    
    session.clear
    @current_user = nil
  end
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def cart_info(product_id)
    @carts  =  session[:cart];
    @carts ||= []

    @isUpdateProduct = false;    
    @carts.each do |cart|
      if cart["Product_id"] ==  product_id
          cart["Quantity"] =  cart["Quantity"].to_i + 1
          @isUpdateProduct = true
          break
      end
    end    
    if @isUpdateProduct == false
      @hashcart = {}
      @hashcart["Product_id"] = product_id
      @hashcart["Quantity"] = 1
      @carts.push(@hashcart)
    end
    session.delete(:product_id)
    session[:cart] = @carts
  end

  def delete_cart
    session.delete(:cart)
  end
end
