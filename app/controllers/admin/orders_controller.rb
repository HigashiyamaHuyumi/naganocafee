class Admin::OrdersController < ApplicationController

  def index # 注文一覧を表示する
    @order = Order.new
    @orders = Order.all
  end

  def show #注文履歴を表示する
    @item = Item.find(params[:id])
  end

  def edit #データを更新するためのフォームを表示す
    @item = Item.find(params[:id])
  end

  def update #データを更新する
   @item = Item.find(params[:id])
    if @item.update(item_params)
     #flash[:notice] ='You have updated book successfully.'
     redirect_to admin_item_path(@item.id)
    else
     render :edit
    end
  end

  def destroy #データを削除する
    @item = Item.find(params[:id])  # データ（レコード）を1件取得
    @item.destroy  # データ（レコード）を削除
    #flash[:notice] ='Book was successfully destroyed.'
    #redirect_to items_path # 投稿一覧画面へリダイレクト
  end

  private

   def order_params
    params.require(:order).permit(:customer_id)
  end
end
