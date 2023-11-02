class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all # 有効な顧客と退会した顧客をすべて取得
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update #顧客の登録情報更新
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = '登録情報を更新しました'
      redirect_to admin_customers_path(@customer) # 更新成功時にマイページにリダイレクト
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_active)
  end

end