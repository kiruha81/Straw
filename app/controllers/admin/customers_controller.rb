class Admin::CustomersController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def index
  end

  def show
  end

  def edit
  end

  def update
  end
end
