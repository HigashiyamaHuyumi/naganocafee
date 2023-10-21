class Admin::OrdersController < ApplicationController

  def index # 注文一覧を表示する
    @orders = Order.all
  end

  def show #注文履歴を表示する
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def edit #データを更新するためのフォームを表示す
    @order = Order.find(params[:id])
  end

  def update #データを更新する
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
      #flash[:notice] = "注文情報が更新されました。"
    else
      render :edit
    end
  end

  def destroy #データを削除する
    @item = Item.find(params[:id])  # データ（レコード）を1件取得
    @item.destroy  # データ（レコード）を削除
    #flash[:notice] ='Book was successfully destroyed.'
    #redirect_to items_path # 投稿一覧画面へリダイレクト
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :postage, :total_payment, :payment_method)
  end
end
