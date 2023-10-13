class Public::CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update,:destroy]

  def create
    item = Item.find(cart_item_params[:item_id]) # フォームから送信されるアイテムIDを取得
    existing_cart_item = current_customer.cart_items.find_by(item_id: item.id)
    amount = cart_item_params[:amount].to_i  # フォームから送信された数量を整数に変換

    if existing_cart_item  #商品がカート内に存在する場合
      existing_cart_item.amount += amount
      existing_cart_item.save
    else  #商品がカート内に存在しない場合
      @cart_item = current_customer.cart_items.build(item: item, amount: amount)
      if @cart_item.save
        flash[:success] = "#{amount}個の#{item.name}をカートに追加しました。"
      else
        flash[:error] = "商品をカートに追加できませんでした。"
        redirect_to item_path(item) #商品詳細ページにリダイレクト
      end
    end
    redirect_to cart_items_path # カートページにリダイレクト
  end

  def index
    @cart_items = current_customer.cart_items # ログイン中の顧客に関連付けられたカート内の商品を取得
    @合計金額 = 0 # 合計金額を初期化

    @cart_items.each do |cart_item|
      @合計金額 += cart_item.subtotal
    end
  end
  
  def update #データを更新する
    if @cart_item.update(cart_item_params)
      flash[:success] = "カートアイテムを更新しました。"
    else
      flash[:error] = "カートアイテムの更新に失敗しました。"
    end
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy
    flash[:success] = "商品をカートから削除しました。"
    redirect_to cart_items_path # カートページにリダイレクト
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:success] = "カート内のすべての商品を削除しました。"
    redirect_to item_index_path
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end