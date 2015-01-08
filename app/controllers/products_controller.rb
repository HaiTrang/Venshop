class ProductsController < ApplicationController
  
  def show
    #@products = Product.all    
    @productdetails = Product.find(params[:id])
    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def create    
    @product = Product.new(product_params)
    if @product.save      
      flash[:success] = "Welcome to the Sample App!"
      redirect_to my_products_path
    else
      render 'new'
    end
  end 

  def edit
    @product = Product.find(params[:id])    
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @product
    else
      render 'edit'
    end
  end 

  def index
    @categories = Category.all      
    @products = Solr::Solr.new(params)
      # @products = Product.where("name like ?", "%#{params[:search]}%").all.paginate(page: params[:page],per_page: 12)      
    # else
    #   if !cat_id.nil?
    #     @products = Product.where(:category_id => cat_id).all.paginate(page: params[:page],per_page: 12)
    #   else
    #     @products = Product.paginate(page: params[:page],per_page: 12)
    #   end
    # end    
  end

  def search
  end

  def product_detail
    @productdetails = Product.find(params[:product_id])
    @categories = Category.all
  end

  def my_products    
    @myproducts = Product.myproducts(session[:user_id])
    @categories = Category.all
  end
  
  def destroy
    Product.find(params[:id]).destroy    
    redirect_to my_products_path
  end
  
  def go_cart
    session[:product_id] = params[:product_id]   
    redirect_to orderdetails_path
  end

  private
    def product_params
      params.require(:product).permit(:name, :price, :description, :urlImage, :urlLargeImage, :catagoy_id,:user_id)
    end
    def cat_id
      cat_id = params[:cat_id]
    end
end

