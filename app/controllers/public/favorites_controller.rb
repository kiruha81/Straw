class Public::FavoritesController < ApplicationController
  # 会員ログインチェック
  before_action :authenticate_customer!
  def create
    @shop = Shop.find(params[:shop_id])
    @favorite = current_customer.favorites.new(shop_id: @shop.id)
    @favorite.save
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @favorite = current_customer.favorites.find_by(shop_id: @shop.id)
    @favorite.destroy
  end

  def index
  end
end
