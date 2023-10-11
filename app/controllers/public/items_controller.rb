class Public::ItemsController < ApplicationController
  
  def index # データの一覧を表示する
    @item = Item.new
    @items = Item.all
  end
  
  def show #データの内容（詳細）を表示する
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(item: @item, amount: 1) # 1 は初期数量の例です
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end

end
