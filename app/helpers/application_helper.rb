module ApplicationHelper
  def copayment(price, customer)
    (price * customer.burden_ratio.to_i * 0.1).floor.to_s(:delimited)
  end

  def subtotal(price, amount)
    price * amount
  end

  def total_price(order_items)
    total = 0
    order_items.each do |order_item|
      total += subtotal(order_item.item.price, order_item.amount).to_i
    end
    total
  end
end
