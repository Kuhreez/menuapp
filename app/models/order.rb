class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :customer

  def total_cost
    order_items_parsed = JSON.parse(order_items)
    return 0 if order_items_parsed.blank?

    order_items_parsed.reduce(0) do |total, item|
      if item['is_side']
        total
      else
        menu_item = MenuItem.find item['menu_item_id']
        total + (item['qty'] * menu_item.price)
      end
    end
  end
end
