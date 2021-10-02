class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :order_items
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :reviews, dependent: :destroy

  attachment :image

  enum is_active: {
    レンタル可: true,
    レンタル不可: false,
  }

  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :is_active, presence: true
end
