class CategoriesController < ApplicationController
  include Product::Controller          
  before_action :list_categories, only: [:show]
  
  def show    
    @products_new = Category.products_new
    @products_rec = Category.products_rec    
  end
end
