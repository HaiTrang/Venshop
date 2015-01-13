class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  
  def self.myproducts(user_id)   
     return Product.where(user_id: user_id)
  end

  def self.list_Categories  	
     return Category.all
  end
  def self.find_products(product_id)
  	return Product.find(product_id)     
  end
  
  def self.search_product(field, value)
    query = field + " = ?"
    return Product.where(query,value)     
  end
end

