class CreateItemCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_categories do |t|
      t.references :item, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
    add_foreign_key :item_categories, :items
    add_foreign_key :item_categories, :categories
  end
end
