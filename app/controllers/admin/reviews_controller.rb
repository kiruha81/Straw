class Admin::ReviewsController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!

  def create
    @review = Review.new(review_params)
    if @review.save!
      redirect_to shop_path(params[:shop_id])
    else
      render :show
    end
  end

  def destroy
    review = Review.find_by(customer_id: params[:customer_id], shop_id: params[:shop_id])
    review.destroy
    redirect_to admin_shop_reviews_path
  end

  def index
    @shop = Shop.all
    @reviews = Review.where(shop_id: params[:shop_id])
    @review_shop = Shop.find(params[:shop_id])
  end

  def all
    @reviews = Review.page(params[:page]).per(10)
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
