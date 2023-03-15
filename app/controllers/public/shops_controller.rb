class Public::ShopsController < ApplicationController
  before_action :ensure_guest_customer, only: [:new, :create, :edit]


  def index
    @shops = Shop.all
    @genres = Genre.all
    @prefectures = Map.prefectures
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @shops = @genre.shops.page(params[:page]).per(6)
      @count = @genre.shops.count
    elsif params[:prefecture_id].present?
      #@map = @prefectures.find(params[:prefecture_id)
      #@shops = @map.shops.page(params[:page]).per(6)
      #@shop = Shop.find(@map.plcuk(:shop_id))
    else
      @shops = Shop.page(params[:page]).per(6)
      @count = Shop.all.count
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @map = @shop.map
    @review = Review.new
    @comment = Comment.new
    @review_avg = Review.where(shop_id: params[:id]).average(:star)
    @review_flg = Review.find_by(customer_id: current_customer.id, shop_id: params[:id])
  end

  def new
    @shop = Shop.new
    @shop.build_map
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.customer_id = current_customer.id
    if @shop.save!
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
    @shop.update(shop_params)
    redirect_to shop_path(@shop.id)
  end



  private



  def shop_params
    params.require(:shop).permit(:title, :shop_name, :body, :genre_id, :customer_id, :map_id, map_attributes:[:id, :shop_id, :prefecture, :address, :latitude, :longitude], shop_images: [])
  end

  def ensure_guest_customer
    if current_customer.name == "ゲストさん"
      redirect_to shops_path, notice: 'ゲストユーザーは投稿できません。'
    end
  end
end
