class Shop < ApplicationRecord
  has_one_attached :shop_main_image
  has_many_attached :shop_images
  belongs_to :genre
  belongs_to :customer
  has_one :map
  # mapを関連した子モデルとして一緒に保存
  accepts_nested_attributes_for :map
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :shop_name, presence: true
  #validates :genre, presence: true

  def favorite_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  #def get_shop_image(width, height)
  #  unless shop_image.attached?
  #      file_path = Rails.root.join('app/assets/images/omise_shop.png')
  #      shop_image.attach(io: File.open(file_path), filename: 'omise_shop.png', content_type: 'image/jpeg')
  #  end
  #  shop_image.variant(resize_to_limit: [width, height]).processed
  #end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "shop_name", "body"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["map"]
  end

end
