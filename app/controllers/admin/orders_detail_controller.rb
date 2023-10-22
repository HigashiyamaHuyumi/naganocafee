class Admin::OrdersDetailController < ApplicationController
    
  def show
    @order = Order.find(params[:id])  #注文IDから注文を取得
    @items = @order.items  #注文に関連付けられた商品を
  end
  
   private

  def order_detail_params
    params.require(:order_detail).permit(:customer_id, :order_id, :amount, :purchase_price)
  end
  
end
