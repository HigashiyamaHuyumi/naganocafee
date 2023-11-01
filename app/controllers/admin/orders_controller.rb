class Admin::OrdersController < ApplicationController

  def index # 注文一覧を表示する
    @orders = Order.page(params[:page])
  end

  def show #注文履歴を表示する
    @order = Order.find(params[:id]) #注文IDから注文を取得
    @order_details = @order.order_details.all # 注文に関連する商品情報を取得
    @total_payment = @order.calculate_total_payment # 合計金額を計算
  end

  def update # データを更新する
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :edit
    end
  end

  def destroy # データを削除する
    @order = Order.find(params[:id]) # 注文を取得
    @order.destroy # 注文を削除
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :postage, :total_payment, :payment_method)
  end

end
