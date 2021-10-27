# frozen_string_literal: true

require 'test_helper'

class CustomerPredictorTest < ActiveSupport::TestCase
  test 'Fred and Fran like Fish on Fridays' do
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

    entree_menu = Menu.create(title: 'Entree', restaurant_id: restaurant.id, includes_side: true)
    fried_catfish_basket = MenuItem.create(
      name: 'Fried Catfish Basket',
      description: "It's not okay to eat a cat, but it's okay to eat a catfish",
      price: 11.00,
      is_side: false
    )

    tilapia = MenuItem.create(
      name: 'Tilapia',
      description: 'A tasty fish',
      price: 12.00,
      is_side: false
    )

    entree_menu.menu_items << fried_catfish_basket
    entree_menu.menu_items << tilapia
    entree_menu.save

    fred = Customer.create(name: 'Fred')
    fran = Customer.create(name: 'Fran')

    fred_order_items1 = [{
      menu_item_id: tilapia.id,
      qty: 1
    }].to_json

    # this is a Friday
    first_order_date = DateTime.new(2021, 10, 1)

    # both Fred and Fran order tilapia
    fred_order_1 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fred_order_items1,
      customer_id: fred.id,
      created_at: first_order_date
    )

    fran_order_items1 = [{
      menu_item_id: tilapia.id,
      qty: 1
    }].to_json

    fran_order_1 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fran_order_items1,
      customer_id: fran.id,
      created_at: first_order_date
    )

    # this is a Saturday
    second_order_date = DateTime.new(2021, 10, 9)

    # Fred orders a tilapia again, Fran orders a salad this time
    fred_order_items2 = [{
      menu_item_id: tilapia.id,
      qty: 1
    }].to_json

    fred_order_2 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fred_order_items1,
      customer_id: fred.id,
      created_at: second_order_date
    )

    fran_order_items2 = [{
      menu_item_id: salad.id,
      qty: 1
    }].to_json

    fran_order_2 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fran_order_items2,
      customer_id: fran.id,
      created_at: second_order_date
    )

    # this is a Friday
    third_order_date = DateTime.new(2021, 10, 15)

    # Fred orders a tilapia yet again, Fran also orders tilapia
    fred_order_items3 = [{
      menu_item_id: tilapia.id,
      qty: 1
    }].to_json

    fred_order_3 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fred_order_items3,
      customer_id: fred.id,
      created_at: third_order_date
    )

    fran_order_items3 = [{
      menu_item_id: tilapia.id,
      qty: 1
    }].to_json

    fran_order_3 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fran_order_items3,
      customer_id: fran.id,
      created_at: third_order_date
    )

    # also a Friday
    fourth_order_date = DateTime.new(2021, 10, 22)

    # Fred orders a fried catfish basket this time, Fran orders tilapia again
    fred_order_items4 = [{
      menu_item_id: fried_catfish_basket.id,
      qty: 1
    }].to_json

    fred_order_4 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fred_order_items4,
      customer_id: fred.id,
      created_at: fourth_order_date
    )

    fran_order_items4 = [{
      menu_item_id: tilapia.id,
      qty: 1
    }].to_json

    fran_order_4 = Order.create(
      restaurant_id: restaurant.id,
      order_items: fran_order_items4,
      customer_id: fran.id,
      created_at: fourth_order_date
    )

    fred_predictor = CustomerPredictor.new(fred)
    fran_predictor = CustomerPredictor.new(fran)

    assert_equal(fred_predictor.likely_day_to_dine, 'Friday')
    assert_equal(fred_predictor.likely_dish_to_order, 'Tilapia')
    assert_equal(fran_predictor.likely_day_to_dine, 'Friday')
    assert_equal(fran_predictor.likely_dish_to_order, 'Tilapia')
  end
end
