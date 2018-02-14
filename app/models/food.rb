class Food < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :ingredients
  has_many :recipes, through: :ingredients
  has_and_belongs_to_many :kitchens

end
