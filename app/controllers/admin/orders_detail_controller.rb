class Admin::OrdersDetailController < ApplicationController
  
   private

  def order_detail_params
    params.require(:order_detail).permit(:customer_id, :order_id, :amount, :purchase_price)
  end
  
end
