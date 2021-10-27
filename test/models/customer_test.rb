require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test 'Customer can have multiple orders' do
    restaurant = Restaurant.create(name: 'Super Cajun Seafood')
    chris = Customer.create(name: 'Chris Oh')
    side_menu = Menu.create(title: 'Sides', restaurant_id: restaurant.id)
    salad = MenuItem.create(
      name: 'Caesar Salad',
      description: "Rumor has it that this was Julius Caesar's favorite dish!",
      price: 4.50,
      is_side: true
    )

    hush_puppies = MenuItem.create(
      name: 'Hush Puppies',
      description: 'Small, savoury, deep-fried round ball made from cornmeal-based batter',
      price: 3.00,
      is_side: true
    )

    side_menu.menu_items << salad
    side_menu.menu_items << hush_puppies
    side_menu.save

    first_order_items = [{
      menu_item_id: salad.id,
      qty: 1
    }].to_json

    first_order = Order.create(restaurant_id: restaurant.id, order_items: first_order_items, customer_id: chris.id)

    second_order_items = [{
      menu_item_id: hush_puppies.id,
      qty: 1
    }].to_json

    second_order = Order.create(restaurant_id: restaurant.id, order_items: second_order_items, customer_id: chris.id)

    order_ids = chris.orders.pluck(:id)
    assert_includes(order_ids, first_order.id)
    assert_includes(order_ids, second_order.id)
  end
end
