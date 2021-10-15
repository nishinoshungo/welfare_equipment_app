class Admin::ReturnItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @return_items = ReturnItem.all
  end

  def update
    # ステータスの変更
    @return_item = ReturnItem.find(params[:id])
    @return_item.update(return_status: "返却済み")

    # 在庫を1つ増やす
    item = Item.find(@return_item.item_id)
    return_stock = item.stock + @return_item.amount
    item.update(stock: return_stock)

    @return_items = ReturnItem.all
    render :index
  end
end
