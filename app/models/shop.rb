class Shop < ApplicationRecord
  has_one_attached :shop_image
  belongs_to :genre
  belongs_to :customer
  has_one :map
  accepts_nested_attributes_for :map
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :shop_name, presence: true

  def get_shop_image(width, height)
    unless shop_image.attached?
        file_path = Rails.root.join('app/assets/images/omise_shop.png')
        shop_image.attach(io: File.open(file_path), filename: 'omise_shop.png', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end

end
