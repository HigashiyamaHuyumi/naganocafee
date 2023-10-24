class Public::ItemsController < ApplicationController
  
  def index # データの一覧を表示する
    @item = Item.new
    @items = Item.page(params[:page])
  end
  
  def show #カートの詳細を表示する
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(item: @item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end

end
