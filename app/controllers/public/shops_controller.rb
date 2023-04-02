class Public::ShopsController < ApplicationController
  # 会員ログインチェック
  before_action :authenticate_customer!
  # ゲストの機能を制限
  before_action :ensure_guest_customer, only: [:new, :create, :edit]


  def index
    @shops = Shop.all
    @genres = Genre.all
    @prefectures = Map.prefectures
    if params[:genre_id].present? # genre_idの取得チェック
      @genre = Genre.find(params[:genre_id])
      @shops = @genre.shops.page(params[:page]).per(6)
      @count = @genre.shops.count
    elsif params[:prefecture_id].present? # prefectureをprefecture_idとして取得チェック
      @prefecture = Map.where(prefecture: params[:prefecture_id])&.pluck(:shop_id)
      @shops = Shop.where(id: @prefecture).page(params[:page]).per(6)
      @count = @shops.count
    else
      @shops = Shop.page(params[:page]).per(6)
      @count = Shop.all.count
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @map = @shop.map
    @comment = Comment.new
    @review = Review.new
    @reviews = @shop.reviews
    @count = @reviews.count
    @review_avg = Review.where(shop_id: params[:id]).average(:star) # shop_idのレビューを全取得し、平均値にする
    @review_flg = Review.find_by(customer_id: current_customer.id, shop_id: params[:id]) # レビューしたかどうかチェック
    @customer = Review.find_by(customer_id: params[:id])
    # ビューカウントがなければcreate
    unless ViewCount.find_by(customer_id: current_customer.id, shop_id: @shop.id)
      current_customer.view_counts.create(shop_id: @shop.id)
    end
  end

  def new
    @shop = Shop.new
    @shop.build_map # shopにmapを作成し保存できるように
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.customer_id = current_customer.id
    @shop.score = Language.get_data(shop_params[:body]) # Natural Language APIの取得
    if @shop.save
      tags = translation(Vision.get_image_data(@shop.shop_main_image)) # タグを取得し日本語に翻訳
      tags.each do |tag|
        @shop.tags.create(name: tag) # 取得したタグを作成
      end
      redirect_to shop_path(@shop.id)
    else
      render :new
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.customer_id = current_customer.id
    @shop.score = Language.get_data(shop_params[:body]) # Natural Language APIの取得
    if @shop.update(shop_params)
      tags = translation(Vision.get_image_data(@shop.shop_main_image)) # タグを取得し日本語に翻訳
      @shop.tags.where(shop_id: @shop.id).destroy_all # 変更する度にタグが増殖されるのを防ぐ
      tags.each do |tag|
        @shop.tags.create(name: tag) # 取得したタグを作成
      end
        redirect_to shop_path(@shop.id)
    else
      render :edit
    end
  end

  def ranking
    @view_count_ranks = Shop.find(ViewCount.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @review_avg = Review.where(shop_id: params[:id]).average(:star)
    @review_ranks = Shop.find(Review.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @favorite_ranks = Shop.find(Favorite.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @comment_ranks = Shop.find(Comment.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @view_counts = ViewCount.all
    @reviews = Review.all
    @favorites = Favorite.all
    @comments = Comment.all

    @shops = [] # 配列にする

    @view_count_ranks.each.with_index(1) do |rank, i|
      @avg = Review.where(shop_id: rank.id).average(:star)
      if @avg.nil?
      else
        @shops << [rank.id, @avg]
      end
    end
    @shops = @shops.sort {|a,b| a[1] <=> b[1]}.reverse

    #@genres = Genre.all
    #@prefectures = Map.prefectures
    #if params[:genre_id].present?
    #  @genre = Genre.find(params[:genre_id])
    #  @view_count_ranks = @genre.shops.page(params[:page]).per(6)
    #  @favorite_ranks = @genre.shops.page(params[:page]).per(6)
    #  @comment_ranks = @genre.shops.page(params[:page]).per(6)
    #elsif params[:prefecture_id].present?
    #  @prefecture = Map.where(prefecture: params[:prefecture_id])&.pluck(:shop_id)
    #  @view_count_ranks = Shop.where(id: @prefecture).page(params[:page]).per(6)
    #  @favorite_ranks = Shop.where(id: @prefecture).page(params[:page]).per(6)
    #  @comment_ranks = Shop.where(id: @prefecture).page(params[:page]).per(6)
    #else
    #end
  end



  private

  #def genre_params
  #  params.require(:genre).permit(:id)
  #end
  def translation(tags)
    arr = []
    tags.each do |tag|
      t = Google::Cloud::Translate.new version: :v2, project_id: ENV["GOOGLE_API_KEY"]
      translated_text = t.translate tag, to: "ja"
      arr.push(translated_text)
    end
    arr
  end


  def shop_params
    params.require(:shop).permit(:title, :shop_name, :shop_main_image, :body, :score, :genre_id, :customer_id, :map_id, map_attributes:[:id, :shop_id, :prefecture, :address, :latitude, :longitude], shop_images: [])
  end

  def ensure_guest_customer
    if current_customer.name == "ゲストさん"
      redirect_to shops_path, notice: 'ゲストユーザーは投稿できません。'
    end
  end
end
