class Map < ApplicationRecord
  belongs_to :shop

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :address, presence: true, uniqueness: true
  #validates :latitude, presence: true, uniqueness: true
  #validates :longitude, presence: true, uniqueness: true

end
