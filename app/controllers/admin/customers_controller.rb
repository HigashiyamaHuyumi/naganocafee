class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
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
      redirect_to admin_customers_path # 更新成功時にマイページにリダイレクト
    else
      render 'admin_customers_edit'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
  end

end