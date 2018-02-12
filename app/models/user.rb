class User < ApplicationRecord
  has_secure_password

  has_one :kitchen
  has_many :foods, through: :kitchen


end
