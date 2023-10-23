class Public::OrdersController < ApplicationController

  def new #注文情報入力
    @order = Order.new
  end

  def confirmation #注文情報確認
    @cart_items = current_customer.cart_items # カート内の商品を取得
    @合計金額 = 0 # 合計金額を初期化
    @cart_items.each do |cart_item|
      @合計金額 += cart_item.subtotal
    end

    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800  # 固定の送料金額（800円）
    @order.total_payment =  @order.postage + @合計金額

    @address_type = params[:order][:address_type]
    if @address_type == "customer_address"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
    elsif @address_type == "shipping_address"
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800  # 固定の送料金額（800円）

    @cart_items = current_customer.cart_items # カート内の商品を取得
    @合計金額 = 0 # 合計金額を初期化
    @cart_items.each do |cart_item|
      @合計金額 += cart_item.subtotal
    end
    @order.total_payment =  @order.postage + @合計金額

    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.payment_method = 0
    elsif @order.payment_method == "transfer"
      @order.payment_method = 1
    end

    @address_type = params[:order][:address_type]
    if @address_type == "customer_address"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
    elsif @address_type == "shipping_address"
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    end

    if @order.save
      @cart_items.destroy_all #注文が正常に保存された場合、カートを空にする
      redirect_to orders_complete_path
    else
      render :new
    end
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