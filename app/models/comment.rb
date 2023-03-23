class Comment < ApplicationRecord
  belongs_to :shop
  belongs_to :customer
  
  validates :title, length: { minimum: 2, maximum: 20 }, presence: true
  validates :comment, length: { minimum: 2, maximum: 500 }, presence: true
end
