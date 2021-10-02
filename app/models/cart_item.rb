class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :item_id, presence: true
  validates :customer_id, presence: true
  validates :amount, numericality: {
    greater_than_or_equal_to: 1,
    only_integer: true,
  }, presence: true
end
