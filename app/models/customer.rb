class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_one_attached :profile_image

  has_many :shops, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_customer, through: :followed, source: :follower
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_customer, through: :follower, source: :followed
  has_many :reviews, dependent: :destroy

  enum gender: {非公開:0, 男性:1, 女性:2}

  enum prefecture: {公開しない:0,北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,茨城県:8,
    栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,新潟県:15,富山県:16,石川県:17,
    福井県:18,山梨県:19,長野県:20,岐阜県:21,静岡県:22,愛知県:23,三重県:24,滋賀県:25,京都府:26,
    大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,
    宮崎県:45,鹿児島県:46,沖縄県:47
  }

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  validates :gender, presence: true
  validates :prefecture, presence: true

  # プロフィール画像設定
  def get_profile_image(width, height) # 引数でサイズ変更
    unless profile_image.attached? # デフォルト設定、profile_imageという名称は上記で設定している
      file_path = Rails.root.join('app/assets/images/def_icon.png')
      profile_image.attach(io: File.open(file_path), filename: 'def_icon.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # deviseでプロフィール編集時にpasswoerd入力を要求されるのをやめるメソッド
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def self.guest
    find_or_create_by!(name: 'ゲストさん' ,email: 'test@example.com', gender: 2, prefecture: 1) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲストさん"
    end
  end

end
