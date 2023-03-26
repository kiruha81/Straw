class Admin::HomesController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def top
    @shops = Shop.all
    @reviews = Review.all
    @comments = Comment.all
    @customers = Customer.all
  end
end
