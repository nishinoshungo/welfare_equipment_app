class CreateFavoriteCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_categories do |t|
      t.integer :customer_id, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
