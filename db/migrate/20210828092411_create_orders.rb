class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
