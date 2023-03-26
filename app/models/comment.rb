class Comment < ApplicationRecord
  belongs_to :shop
  belongs_to :customer

  validates :title, presence: true
  validates :comment, length: { minimum: 1, maximum: 500 }, presence: true
end
