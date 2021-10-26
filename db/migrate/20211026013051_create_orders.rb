class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :restaurant, index: true
      t.json :order_items, default: []

      t.timestamps
    end
  end
end
