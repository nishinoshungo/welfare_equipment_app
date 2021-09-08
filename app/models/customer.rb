class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :favorite_items
  has_many :orders
  has_many :favorite_categories
  has_many :reviews

  def already_favorited?(item)
    self.favorite_items.exists?(item_id: item.id)
  end

  enum burden_ratio: {"1割負担": 1, "2割負担": 2, "3割負担": 3, "10割負担": 4}
  enum is_active: {"有効": true, "退会": false}

end
