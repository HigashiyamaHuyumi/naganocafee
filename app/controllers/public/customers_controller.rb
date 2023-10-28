class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:show, :update, :confirm, :withdrawal]

  def my_page #顧客のマイページ
    @customer = current_customer
  end

  def edit #顧客の登録情報編集画面
    @customer = current_customer
  end

  def update #顧客の登録情報更新
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = '登録情報を更新しました'
      redirect_to customers_my_page_path # 更新成功時にマイページにリダイレクト
    else
      render 'customers_information_edit'
    end
  end

  def confirm #退会確認画面
    is_matching_login_customer
    @customer = Customer.find(params[:id])
  end

  def withdrawal  #退会画面
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path, notice: "アカウントが削除されました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
  end

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to customer_path(current_customer)
    end
  end

end
