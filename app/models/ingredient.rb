class Ingredient < ApplicationRecord
  validates :food_id, presence: true, uniqueness: true
  validates :measurement_unit, presence: true
  validates :quanity, presence: true, numericality: true

  has_and_belongs_to_many :recipes
  belongs_to :food


end
