class ReturnItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  enum return_status: {
    "未返却": 0,
    "返却済み": 1,
  }
end
