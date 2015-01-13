class ProductsController < ApplicationController
  include Product::Controller

  before_action :list_categories, only: [:new, :my_products, :edit, :show, :search, :product_detail, :index]  
  before_action :find_products ,only: [:edit,:update,:show, :product_detail, :destroy]

  def new
    @product = Product.new
  end

  def create    
    @product = Product.new(product_params)
    if @product.save
      redirect_to my_products_path
    else
      render 'new'
    end
  end 

  def edit
    unless logged_in?
      redirect_to root_path
    end
  end

  def update
    if @product.update_attributes(product_params)      
      flash[:success] = "Profile updated"
      redirect_to @product
    else
      render 'edit'
    end
  end 

  def show    
    
  end
  def index    
    if !cat_id.nil?
      @products = Product.search_product("category_id", cat_id).all.paginate(page: params[:page],per_page: 12)
    else
      @products = Product.paginate(page: params[:page],per_page: 12)
    end  
  end

  def search
    @products = Solr::Solr.new(params)
    
  end
  def product_detail     
  end

  def my_products    
    # @myproductst_tmp = Product.myproducts(session[:user_id])#.all.paginate(page: params[:page],per_page: 12)    
    @products =Product.myproducts(session[:user_id]).all.paginate(page: params[:page],per_page: 12)
  end
  
  def destroy
    @product.destroy    
    redirect_to my_products_path
  end
  
  def go_cart
    session[:product_id] = params[:id]   
    redirect_to orderdetails_path
  end

  private
    def product_params
       params.require(:product).permit(:name, :price, :description, :urlImage, :urlLargeImage, :catagoy_id,:user_id,:recommend)      
    end
    def cat_id
      cat_id = params[:cat_id]
    end

end

