class Public::CustomersController < ApplicationController
  def index
    @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @shops = @customer.shops
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
  end

  def withdrawal
  end

  def customer_params
    params.require(:customer).permit(:name, :gender, :prefecture, :introduction, :email, :profile_image, :is_deleted)
  end
end
