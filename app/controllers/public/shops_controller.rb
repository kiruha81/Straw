class Public::ShopsController < ApplicationController
  def index
    @shops = Shop.all

  end

  def show
    @shop = Shop.find(params[:id])
    @map = @shop.map
    @review = Review.new
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
    params.require(:shop).permit(:title, :shop_name, :shop_image, :body, :genre_id, :customer_id, :map_id, map_attributes:[:id, :shop_id, :address, :latitude, :longitude])
  end
end
