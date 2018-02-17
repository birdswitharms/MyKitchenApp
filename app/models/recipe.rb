class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_and_belongs_to_many :ingredients
  has_many :steps

end
