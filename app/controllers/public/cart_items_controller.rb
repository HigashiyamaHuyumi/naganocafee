class Public::CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:destroy]
   
  def create
    item = Item.find(params[:item_id])
    amount = params[:cart_item][:amount].to_i
    @cart_item = current_customer.cart.cart_items.build(item: item, amount: amount)

    if @cart_item.save
      #flash[:success] = "#{quantity}個の#{item.name}をカートに追加しました。"
      redirect_to index_path # カートページにリダイレクト
    else
      #flash[:error] = "商品をカートに追加できませんでした。"
      redirect_to item_path(item) # 商品詳細ページにリダイレクト
    end
  end
  
  
  def index
    @cart_items = CartItem.page(params[:page])  #ページ分の決めた数のデータだけ新しい順に取得
  end

  # カートからアイテムを削除するアクション
  def destroy
    @cart_item.destroy
    flash[:success] = "商品をカートから削除しました。"
    redirect_to cart_items_path # カートページにリダイレクト
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
