class Admin::CommentsController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def create
  end

  def destroy
  end

  def index
    @shop = Shop.find(params[:shop_id])
    @comments = Comment.page(params[:page]).per(6)
  end
end
