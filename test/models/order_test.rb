require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'You can order a dinner salad as a standalone dish with selection of dressing' do
    restaurant = Restaurant.create(name: 'Super Cajun Seafood')
    side_menu = Menu.create(title: 'Sides', restaurant_id: restaurant.id)
    salad = MenuItem.create(
      name: 'Caesar Salad',
      description: "Rumor has it that this was Julius Caesar's favorite dish!",
      price: 4.50,
      is_side: true
    )

    side_menu.menu_items << salad
    side_menu.save

    ranch = AddOn.create(name: 'Ranch', menu_item_id: salad.id)
    blue_cheese = AddOn.create(name: 'Blue Cheese', menu_item_id: salad.id)
    honey_mustard = AddOn.create(name: 'Honey Mustard', menu_item_id: salad.id)

    # Ordering 1 salad with 2 ranch dressings and 2 honey mustard
    order_items = [{
      menu_item_id: salad.id,
      qty: 1,
      add_ons: [{
        add_on_id: ranch.id,
        qty: 2
      }, {
        add_on_id: honey_mustard.id,
        qty: 2
      }]
    }].to_json

    chris = Customer.create(name: 'Chris Oh')
    order = Order.create(restaurant_id: restaurant.id, order_items: order_items, customer_id: chris.id)

    assert_equal(order.total_cost, 4.50)
    order_items_parsed = JSON.parse(order.order_items)
    add_on_ids = order_items_parsed.first['add_ons'].map { |add_on| add_on['add_on_id'] }
    add_on_names = AddOn.where(id: add_on_ids).pluck(:name)
    # we got some ranch
    assert_includes(add_on_names, 'Ranch')
    # and also some honey mustard
    assert_includes(add_on_names, 'Honey Mustard')
  end

  test 'You can order a dinner salad as a side dish with selection of dressing' do
    restaurant = Restaurant.create(name: 'Super Cajun Seafood')
    side_menu = Menu.create(title: 'Sides', restaurant_id: restaurant.id)
    salad = MenuItem.create(
      name: 'Caesar Salad',
      description: "Rumor has it that this was Julius Caesar's favorite dish!",
      price: 4.50,
      is_side: true
    )

    side_menu.menu_items << salad
    side_menu.save

    ranch = AddOn.create(name: 'Ranch', menu_item_id: salad.id)
    blue_cheese = AddOn.create(name: 'Blue Cheese', menu_item_id: salad.id)
    honey_mustard = AddOn.create(name: 'Honey Mustard', menu_item_id: salad.id)

    entree_menu = Menu.create(title: 'Entree', restaurant_id: restaurant.id, includes_side: true)
    fried_catfish_basket = MenuItem.create(
      name: 'Fried Catfish Basket',
      description: "It's not okay to eat a cat, but it's okay to eat a catfish",
      price: 11.00,
      is_side: false
    )

    entree_menu.menu_items << fried_catfish_basket
    entree_menu.save

    order_items = [{
      menu_item_id: fried_catfish_basket.id,
      qty: 1
    }, {
      menu_item_id: salad.id,
      qty: 1,
      is_side: true,
      add_ons: [{
        add_on_id: ranch.id,
        qty: 2
      }]
    }].to_json

    chris = Customer.create(name: 'Chris Oh')
    order = Order.create(restaurant_id: restaurant.id, order_items: order_items, customer_id: chris.id)
    # does not include the price of the salad, since it comes with the entree
    assert_equal(order.total_cost, 11.00)
  end
end
