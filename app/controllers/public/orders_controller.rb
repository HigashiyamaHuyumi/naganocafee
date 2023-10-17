class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end

  def create #注文確定処理
  end

  def confirmation
    @cart_items = current_customer.cart_items # カート内の商品を取得
    @合計金額 = 0 # 合計金額を初期化
    @cart_items.each do |cart_item|
      @合計金額 += cart_item.subtotal
    end
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.shipping_address == "customer_address" #ご自身の住所を使用する場合
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = "#{current_customer.last_name} #{current_customer.first_name}"
    end
    # 注文情報を表示するビューにデータを渡す
    render 'confirmation' # 注文確認画面のビューを表示

  end

  def complete #注文完了画面
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