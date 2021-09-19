class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    #パラメーターに:customer_idが含まれる時、その顧客の注文履歴だけを表示する。
    if params[:customer_id].present?
      customer = Customer.find(params[:customer_id])
      @orders = customer.orders
    else
      #パラメーターに:customer_idが含まれない時は、全注文履歴を表示する。
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
