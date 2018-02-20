class Ingredient < ApplicationRecord
  validates :food_id, presence: true, uniqueness: true
  validates :measurement_unit, presence: true
  validates :quantity, presence: true, numericality: true
  validates :food_id, uniqueness: { scope: [:measurement_unit, :quantity] }


  has_and_belongs_to_many :recipes
  belongs_to :food


end
