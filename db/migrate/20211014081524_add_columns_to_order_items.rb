class AddColumnsToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :end_date, :datetime
    add_column :order_items, :rental_status, :intager, default: 0
  end
end
