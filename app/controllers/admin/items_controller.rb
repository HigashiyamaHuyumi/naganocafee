class Admin::ItemsController < ApplicationController

  def index # データの一覧を表示する
    @item = Item.new
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end
  
  def create #データを追加（保存）する
    @item = Item.new(item_params)
    if @item.save
      #flash[:notice] ='You have created book successfully.'
      #redirect_to book_path(@book)
    else
      @items = Item.all
      render :index
    end
  end

  def show #データの内容（詳細）を表示する
    @item = Item.new
    @item = Item.find(params[:id])
    #@profile_image = @user.get_profile_image if @user.present?
  end

  def edit #データを更新するためのフォームを表示す
    @item = Item.find(params[:id])
  end

  def update #データを更新する
   @item = Item.find(params[:id])
    if @item.update(item_params)
     #flash[:notice] ='You have updated book successfully.'
     #redirect_to item_path(@item.id)
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

  def item_params
    params.require(:item).permit(:name, :introduction, :prise)
  end

end
