class Public::FavoriteItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @favorite_items = current_customer.favorite_items.page(params[:page])
    @genres = Genre.all
  end

  def create
    favorite_item = FavoriteItem.new
    favorite_item.customer_id = current_customer.id
    favorite_item.item_id = params[:item_id]
    favorite_item.save
    @item = favorite_item.item
    # redirect_to "/items/#{params[:item_id]}"
  end

  def destroy
    favorite_item = FavoriteItem.find_by(item_id: params[:item_id])
    favorite_item.destroy
    @item = favorite_item.item
    # redirect_to "/items/#{params[:item_id]}"
  end
end
