class FavoriteCategory < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :category, dependent: :destroy
end
