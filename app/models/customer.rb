class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :favorite_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :categories, through: :favorite_categories

  def already_favorited?(item) #ユーザーによって既に商品がお気に入り登録されてるか確かめるメソッド
    self.favorite_items.exists?(item_id: item.id)
  end


  enum burden_ratio: {"1割負担": 1, "2割負担": 2, "3割負担": 3, "10割負担": 4}
  enum is_active: {"有効": true, "退会": false}


  def active_for_authentication?
    super && (self.is_active == "有効")
  end

end
