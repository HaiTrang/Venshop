class AddEmailToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :email, :text
  end
end
