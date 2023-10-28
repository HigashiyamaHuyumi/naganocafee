class HomesController < ApplicationController
  def top
    @new_items = Item.order(created_at: :desc).limit(4) # 例: 最新の4個のアイテムを取得
  end
  
  def about
  end
end
