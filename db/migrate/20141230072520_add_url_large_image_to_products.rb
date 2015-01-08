class AddUrlLargeImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :urlLargeImage, :text
  end
end
