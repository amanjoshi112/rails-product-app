class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.decimal :total_price

      t.timestamps
    end
    add_index :line_items, :order_id
    add_index :line_items, :product_id
  end
end
