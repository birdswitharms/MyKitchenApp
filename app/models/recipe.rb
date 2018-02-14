class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true


  has_and_belongs_to_many :ingredients
  # has_and_belongs_to_many :foods, through: :ingredients

end
