class AddUsernameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :username, :text
  end
end
