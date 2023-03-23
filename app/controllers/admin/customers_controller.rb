class Admin::CustomersController < ApplicationController
  # 管理者ログインチェック
  before_action :authenticate_admin!
  def index
    @customers = Customer.page(params[:page]).per(6)
  end

  def show
    @customer = Customer.find(params[:id])
    @shops = @customer.shops.page(params[:page]).per(5)
    #@review = Review.find_by(customer_id: params[:id])
    @review_avg = Review.where(shop_id: params[:id]).average(:star)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :gender, :prefecture, :introduction, :email, :is_deleted)
  end

end
