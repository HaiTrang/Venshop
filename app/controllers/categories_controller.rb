class CategoriesController < ApplicationController
	def show
    @category = Category.all    
    @products_new = Category.products_new
    @products_rec = Category.products_rec
    
  end
end
