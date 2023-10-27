class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:show, :edit, :update, :confirm, :withdrawal]

  def my_page #顧客のマイページ
    is_matching_login_customer
    @customer = Customer.find(params[:id])
    render :my_page
  end

  def edit #顧客の登録情報編集画面
    is_matching_login_customer
    @customer = Customer.find(params[:id])
  end

  def update #顧客の登録情報更新
    is_matching_login_customer
    @customer = Customer.find(params[:id]) #ユーザーの取得
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
      flash[:notice] = '登録情報を更新しました'
    else
      render 'edit'
    end
  end

  def confirm
    is_matching_login_customer
    @customer = Customer.find(params[:id])
  end

  def withdrawal
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
