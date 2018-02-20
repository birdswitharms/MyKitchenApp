class Ingredient < ApplicationRecord
  validates :food_id, presence: true
  validates :measurement_unit, presence: true
  # add later
  # validates :quantity, presence: true, numericality: true
  validates :food_id, uniqueness: { scope: [:measurement_unit] }


  has_and_belongs_to_many :recipes
  belongs_to :food


end
