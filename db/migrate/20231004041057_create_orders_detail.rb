class CreateOrdersDetail < ActiveRecord::Migration[6.1]
  def change
    create_table :orders_detail do |t|
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :amount, null: false
      t.integer :purchase_price, null: false
      t.timestamps
    end
  end
end
