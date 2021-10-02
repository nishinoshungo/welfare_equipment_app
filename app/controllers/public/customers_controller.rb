class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to customers_my_page_path
  end

  def unsubscribe
  end

  def withdraw
    customer = current_customer
    customer.is_active = "退会"
    customer.save
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :email,
      :postal_code,
      :address,
      :telephone_number,
      :burden_ratio,
      category_ids: []
    )
  end
end
