class Admin::CustomersController < ApplicationController
  
  def index # データの一覧を表示する
    @customers = Customer.all
  end

  def show #データの内容（詳細）を表示する
    @customer = Customer.find(params[:id])
  end

  def edit #データを更新するためのフォームを表示す
    @customer = Customer.find(params[:id])
  end

  def update #データを更新する
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     #flash[:notice] ='You have updated book successfully.'
     #redirect_to admin_item_path(@item.id)
    else
     #render :edit
    end
  end

  def destroy #データを削除する
    @customer = Customer.find(params[:id])  # データ（レコード）を1件取得
    @customer.destroy  # データ（レコード）を削除
    #flash[:notice] ='Book was successfully destroyed.'
    #redirect_to items_path # 投稿一覧画面へリダイレクト
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
  end

  
end
