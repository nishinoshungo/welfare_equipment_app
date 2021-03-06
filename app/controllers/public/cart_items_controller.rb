class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.amount.nil?
      @cart_item = CartItem.new
      @review = Review.new
      @genres = Genre.all
      @item = Item.find(params[:cart_item][:item_id])
      @reviews = @item.reviews.page(params[:page]).per(5).reverse_order
      flash[:alert] = "数量を指定してください。"
      render "public/items/show"
      return
    end
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.customer_id == current_customer.id
      cart_item.destroy
    end
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
