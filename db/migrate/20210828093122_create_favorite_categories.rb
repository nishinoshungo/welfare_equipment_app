class CreateFavoriteCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_categories do |t|
      t.references :category, foreign_key: true
      t.references :customer, foreign_key: true
      t.timestamps
    end
    add_foreign_key :favorite_categories, :categories
    add_foreign_key :favorite_categories, :customers
  end
end
