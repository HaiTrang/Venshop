class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  
   def self.myproducts(user_id)   
     return Product.where(user_id: user_id)
  end

end
