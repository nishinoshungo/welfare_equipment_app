class FavoriteItem < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :item, dependent: :destroy
end
