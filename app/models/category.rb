class Category < ActiveRecord::Base  
  has_many :products
  
  def self.products_new
  	return Product.limit(6).order('created_at desc')
  end

  def self.products_rec
  	return Product.where(recommend: true).limit(6).order('id asc')
  end
  
  def self.all_category
  	return Category.all
  end

end
