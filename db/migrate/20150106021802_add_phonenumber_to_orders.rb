class AddPhonenumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :phonenumber, :text
  end
end
