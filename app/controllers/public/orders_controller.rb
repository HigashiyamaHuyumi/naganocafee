class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end

  def confirmation
    @cart_items = current_customer.cart_items # カート内の商品を取得
    @合計金額 = 0 # 合計金額を初期化
    @cart_items.each do |cart_item|
      @合計金額 += cart_item.subtotal
    end
    
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800  # 固定の送料金額（800円）
    @order.total_payment =  @order.postage + @合計金額
    
    @address_type = params[:order][:select_address]
    
    if @address_type == "customer_address"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
      
    elsif @address_type == "shipping_address"
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    end
    
    if @order.save  #注文情報を保存できた場合の処理（ここにリダイレクトなどを追加）
      redirect_to create_path
    else #注文情報を保存できなかった場合の処理（エラーメッセージ表示などを追加）
      render 'confirmation', total_payment: @total_payment  # 合計金額をビューに渡す
    end
  end
  
  def create #注文確定処理
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