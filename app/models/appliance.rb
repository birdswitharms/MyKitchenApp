class Appliance < ApplicationRecord

  has_many :users, through: :appliances_users
  has_many :recipes, through: :appliances_recipes
  has_and_belongs_to_many :users

end
