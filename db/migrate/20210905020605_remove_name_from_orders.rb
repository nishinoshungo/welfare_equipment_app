class RemoveNameFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :name, :string
  end
end
