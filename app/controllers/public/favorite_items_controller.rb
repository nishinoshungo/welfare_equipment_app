class Public::FavoriteItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @favorite_items = current_customer.favorite_items
  end

  def create
    favorite_item = FavoriteItem.new
    favorite_item.customer_id = current_customer.id
    favorite_item.item_id = params[:item_id]
    favorite_item.save
    redirect_to "/items/#{params[:item_id]}"
  end

  def destroy
    favorite_item = FavoriteItem.find_by(item_id: params[:item_id])
    favorite_item.destroy
    redirect_to "/items/#{params[:item_id]}"
  end
end
