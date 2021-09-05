class Public::OrdersController < ApplicationController
  def index
  end

  def show
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
    end
    
    # 注文確定後、かごの中身を空にし、注文完了画面へ
    cart_items.destroy_all
    redirect_to "/orders/complete"
  end

  def confirm
    @order = Order.new
    @order_item = OrderItem.new
    @cart_items = current_customer.cart_items
  end

  def complete
  end
end
