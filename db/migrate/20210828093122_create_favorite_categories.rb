class CreateFavoriteCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_categories do |t|
      t.references :category, foreign_key: true
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
