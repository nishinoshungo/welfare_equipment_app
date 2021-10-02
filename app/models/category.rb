class Category < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :favorite_categories, dependent: :destroy
  has_many :items, through: :item_categories
  has_many :customers, through: :favorite_categories

  validates :name, presence: true
end
