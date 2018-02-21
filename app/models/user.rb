class User < ApplicationRecord
  has_secure_password

  has_many :pantries
  has_many :foods, through: :pantries
  has_many :recipes
  has_many :favorites

  # has_many :recipes, through: :foods # this will be made into method

end
