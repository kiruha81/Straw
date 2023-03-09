class Admin::CommentsController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def create
  end

  def destroy
  end
end
