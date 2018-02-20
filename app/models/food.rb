class Food < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :ingredients
  has_many :recipes, through: :ingredients # goes through two
  # ADD BACK LATER
  # belongs_to :category
  has_many :pantries
  has_many :users, through: :pantries

end
