class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  belongs_to :customer
  has_many :order_details

  #注文内のすべての注文詳細の小計を合計して合計金額を計算
  def calculate_total_payment
    total_payment = 0
    self.order_details.each do |order_detail|
      total_payment += order_detail.calculate_subtotal
    end
    total_payment
  end

end
