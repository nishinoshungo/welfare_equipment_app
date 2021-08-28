class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :item_id, null: false
      t.integer :customer_id, null: false
      t.text :comment, null: false
      t.float :rate, null: false
      t.timestamps
    end
  end
end
