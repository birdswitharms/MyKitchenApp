class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :pantries
  has_many :foods, through: :pantries
  has_many :recipes
  has_many :favorites
  has_many :reviews
  has_many :shoppinglist
  has_many :histories

  has_and_belongs_to_many :appliances

end
