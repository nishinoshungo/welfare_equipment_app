class CreateReturnItems < ActiveRecord::Migration[5.2]
  def change
    create_table :return_items do |t|
      t.integer :item_id, null: false
      t.integer :customer_id, null: false
      t.integer :amount, null: false
      t.integer :return_status, null: false, default: 0
      t.timestamps
    end
  end
end
