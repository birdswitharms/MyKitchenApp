class Step < ApplicationRecord

  validates :content, presence: true
  belongs_to :recipe

end
