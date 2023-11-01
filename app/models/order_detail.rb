class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  #注文詳細ごとの小計（subtotal）を計算
  def calculate_subtotal
    self.amount * self.purchase_price
  end
end
