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

  def rental_period(order_item)
    if order_item.rental_status == "レンタル中"
      (DateTime.now.to_i - order_item.created_at.to_i) / 60 / 60 / 24 / 30 + 1
    else
      (order_item.end_date.to_i - order_item.created_at.to_i) / 60 / 60 / 24 / 30 + 1
    end
  end

  def billing_amount(order_item)
    rental_period(order_item) * subtotal(order_item.item.price, order_item.amount)
  end

  def total_billing_amount(orders)
    total = 0
    orders.each do |order|
      order.order_items.each do |order_item|
        total = total + billing_amount(order_item)
      end
    end
    total
  end

end
