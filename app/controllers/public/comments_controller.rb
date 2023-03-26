class Public::CommentsController < ApplicationController
  # 会員ログインチェック
  before_action :authenticate_customer!

  def create
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    comment = current_customer.comments.new(comment_params)
    comment.shop_id = @shop.id
    comment.save
    redirect_to shop_path(@shop)
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    Comment.find_by(params[:id], shop_id: params[:shop_id]).destroy
    redirect_to shop_path(@shop)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end
