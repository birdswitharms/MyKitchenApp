class Favorite < ApplicationRecord

  validates :user_id, presence: true
  validates :recipe_id, presence: true
  validates :created_at, presence: true

  validates :user_id, uniqueness: { scope: [:recipe_id] }

  belongs_to :user
  belongs_to :recipe

end
