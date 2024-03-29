class Public::MapsController < ApplicationController
  # 会員ログインチェック
  before_action :authenticate_customer!
  def index
      @maps = Map.all
      @map = Map.new
  end

  def create
      map = Map.new(map_params)
      map.save
      redirect_to maps_path
  end

  def destroy
      map = Map.find(params[:id])
      map.destroy
      redirect_to action: :index
  end

  private

  def map_params
  params.require(:map).permit(:address, :latitude, :longitude)
  end
end
