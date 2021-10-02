class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :item
# rateカラムに1以上5以下の数値しか登録できないようにする
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  validates :comment, presence: true
end
