class FavoriteItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates_uniqueness_of :item_id, scope: :customer_id #1人が1つの商品に対して1つしかいいねをつけられないようにする
end
