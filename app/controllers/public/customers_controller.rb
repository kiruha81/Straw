class Public::CustomersController < ApplicationController
  # 会員ログインチェック
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  def index
    @customers = Customer.page(params[:page]).per(6)
  end

  def show
    @customer = Customer.find(params[:id])
    @shops = @customer.shops
    #@review = Review.find_by(customer_id: params[:id])
    @review_avg = Review.where(shop_id: params[:id]).average(:star)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.id = current_customer.id
    @customer.update(customer_params)
    redirect_to customer_path(current_customer)
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会が完了しました！"
    redirect_to root_path
  end

  def favorites
    @customers = Customer.all
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :gender, :prefecture, :introduction, :email, :profile_image, :is_deleted)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "ゲストさん"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
