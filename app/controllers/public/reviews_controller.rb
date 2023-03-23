class Public::ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    if @review.save!
      redirect_to shop_path(params[:shop_id])
    else
      render :show
    end
  end

  def destroy
    review = Review.find_by(customer_id: current_customer.id, shop_id: params[:shop_id])
    # 自分自身の評価のみ削除を許可
    redirect_to shops_path and return unless review.customer_id == current_customer.id
    review.destroy() # 評価削除
    redirect_to shop_path(params[:shop_id])
  end

  def index
    @shop = Shop.all
    @reviews = Review.where(shop_id: params[:shop_id])
  end

  private

  def review_params
    # mergeメソッドでユーザーID, 投稿_IDをStrongParameterに追加
    params.require(:review).permit(:star)
          .merge(
            customer_id: current_customer.id,
            shop_id: params[:shop_id]
          )
  end
end
