class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :item_id, presence: true
  validates :order_id, presence: true
  validates :price, presence: true
end
