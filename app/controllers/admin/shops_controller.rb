class Admin::ShopsController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def index
    @shops = Shop.all
    @genres = Genre.all
    @prefectures = Map.prefectures
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @shops = @genre.shops.page(params[:page]).per(6)
      @count = @genre.shops.count
    elsif params[:prefecture_id].present?
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
    @review_avg = Review.where(shop_id: params[:id]).average(:star)
    @customer = Review.find_by(customer_id: params[:id])
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.update(shop_params)
    redirect_to admin_shop_path(@shop.id)
  end
  
  def ranking
    @view_count_ranks = Shop.find(ViewCount.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @review_ranks = Shop.find(Review.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @favorite_ranks = Shop.find(Favorite.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @comment_ranks = Shop.find(Comment.group(:shop_id).order('count(shop_id) desc').limit(3).pluck(:shop_id))
    @view_counts = ViewCount.all
    @reviews = Review.all
    @favorites = Favorite.all
    @comments = Comment.all
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

  def shop_params
    params.require(:shop).permit(:title, :shop_name, :body, :is_hidden, :genre_id, :customer_id, :map_id, map_attributes:[:id, :shop_id, :prefecture, :address, :latitude, :longitude], shop_images: [])
  end

end
