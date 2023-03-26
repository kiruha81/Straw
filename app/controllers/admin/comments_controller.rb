class Admin::CommentsController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!

  def destroy
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    Comment.find(params[:id]).destroy
    redirect_to admin_shop_path(@shop)
  end

  def index
    @shop = Shop.find(params[:shop_id])
    @comments = Comment.page(params[:page]).per(6)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end
