class Public::OrdersController < ApplicationController

  def new　#注文情報入力
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
  end

  def confirmation #注文情報確認
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    render 'confirmation' # 注文確認画面のビューを表示
  end

  def complete #注文完了画面
  end

  def create #注文確定処理
  end

  def index #注文履歴画面
  end

  def show　#注文履歴詳細画面
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :postage, :total_payment, :payment_method)
  end

end