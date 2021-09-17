class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    # 注文の確定
    order = Order.new
    order.customer_id = current_customer.id
    order.save

    # order_itemsテーブルに注文された商品を１つずつ保存する
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item.item_id
      order_item.order_id = order.id
      order_item.price = cart_item.item.price
      order_item.amount = cart_item.amount
      order_item.save

      #商品を購入した分だけ在庫数を減らす
      item = Item.find(order_item.item_id)
      item.stock = item.stock - order_item.amount
      if item.stock == 0
        item.is_active = "レンタル不可"
      end
      item.save
    end

    # 注文確定後、かごの中身を空にし、注文完了画面へ
    cart_items.destroy_all
    redirect_to "/orders/complete"
  end

  def confirm
    @order = Order.new
    @order_item = OrderItem.new
    @cart_items = current_customer.cart_items
    if @cart_items.blank?
      flash[:alert] = "カートが空です。"
      render "public/cart_items/index"
    end
  end

  def complete
  end
end
