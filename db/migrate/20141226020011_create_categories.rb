class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :name
      t.text :description
      t.text :createDate      

      t.timestamps
    end
  end
end
