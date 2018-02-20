class Food < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :ingredients
  has_many :recipes, through: :ingredients # goes through two
  # has_and_belongs_to_many :users
  belongs_to :category
  has_many :pantries
  has_many :users, through: :pantries

end
