class Category < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :favorite_categories, dependent: :destroy
end
