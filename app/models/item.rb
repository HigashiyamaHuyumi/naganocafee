class Item < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image
  has_many :cart_items
  has_many :orders
  has_many :order_details

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # 画像のサイズを100x100ピクセルに変更するメソッド
  def resize_image
    if image.attached?
      image.variant(resize: '100x100')
    else
      # デフォルトの画像を表示する場合の処理
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      return File.open(file_path)
    end
  end

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end
