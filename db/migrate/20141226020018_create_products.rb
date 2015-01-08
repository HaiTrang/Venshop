class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :price
      t.text :description
      t.text :unitCost
      t.text :urlImage
      t.text :createDate
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps
    end
    
  end
  
end
