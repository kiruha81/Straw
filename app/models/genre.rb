class Genre < ApplicationRecord
  has_many :shops, dependent: :destroy

  validates :name, presence: true
end
