class Admin::HomesController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def top
  end
end
