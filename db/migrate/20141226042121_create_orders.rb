class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :orderdate
      t.datetime :shipdate
      t.text :ShippingAddress
      t.integer :ShippingCost
      t.text :OrderStatus
      t.text :description
      t.references :User, index: true

      t.timestamps      
    end

  
  end
end
