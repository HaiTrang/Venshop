module Product::Controller
  extend ActiveSupport::Concern

  def list_categories
    @categories = Product.list_Categories
  end

  def find_products
    # @product = Product.find_products(params[:id])
    @product = Product.find(params[:id])
  end

  def find_user
    
    @user = User.find_user(session[:user_id])
  end
  
end
