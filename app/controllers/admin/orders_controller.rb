class Admin::OrdersController < ApplicationController

  def index # 注文一覧を表示する
    @orders = Order.page(params[:page])
  end

  def show #注文履歴を表示する
    @order = Order.find(params[:id]) #注文IDから注文を取得
    @order_details = @order.order_details.all # 注文に関連する商品情報を取得
  end

  def update # データを更新する
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
      #flash[:notice] = "注文情報が更新されました。"
    else
      render :edit
    end
  end

  def destroy # データを削除する
    @order = Order.find(params[:id]) # 注文を取得
    @order.destroy # 注文を削除
    #flash[:notice] ='注文が正常に削除されました。'
    #redirect_to orders_path # 注文一覧画面へリダイレクト
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :postage, :total_payment, :payment_method)
  end
end
