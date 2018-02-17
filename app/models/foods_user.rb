class FoodsUser < ApplicationRecord
  has_many :user_id
  has_many :food_id
end
