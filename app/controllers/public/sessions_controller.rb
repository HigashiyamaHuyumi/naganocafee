# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  
  protected
  
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email]) # 入力されたemailからアカウントを1件取得
  
    if !@customer # アカウントが見つからない場合
      flash[:alert] = "アカウントが見つかりませんでした。"
      redirect_to new_customer_registration_path
    elsif !@customer.active? # 退会している場合
      flash[:alert] = "退会済みのアカウントです。"
      redirect_to new_customer_registration_path
    end
  end
   
  def customer_state
  # ここにcustomer_stateメソッドの実装を追加
  end
  # before_action :configure_sign_in_params, only: [:create]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
