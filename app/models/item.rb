class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :order_items
  has_many :item_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy

  attachment :image

  enum is_active: {レンタル可: true, レンタル不可: false}

end
