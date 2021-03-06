# frozen_string_literal: true

class DeviseCustomers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    customers_my_page_path(resource)
  end

  protected

  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      if @customer.valid_password?(params[:customer][:password]) &&
        (@customer.active_for_authentication? == false)
        flash[:error] = "退会済みです。"
        redirect_to new_customer_session_path
      elsif @customer.valid_password?(params[:customer][:password]) == false
        flash[:error] = "パスワードに誤りがあります。"
        redirect_to new_customer_session_path
      end
    else
      flash[:error] = "入力内容に誤りがあります。"
      redirect_to new_customer_session_path
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
