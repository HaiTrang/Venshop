class StaticPagesController < ApplicationController
  def home
  end

  def help
  	
  end

  def contact
  	@categories = Category.all
  end
  def about
  	
  end
  def new
  	
  end
end
