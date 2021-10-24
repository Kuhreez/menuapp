require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test 'Restaurant has multiple menus' do
    restaurant = Restaurant.create(name: 'Super Cajun Seafood')
    menu1 = Menu.create(title: 'Appetizers', restaurant_id: restaurant.id)
    menu2 = Menu.create(title: 'Main Dish', restaurant_id: restaurant.id)
    menu_ids = restaurant.menus.pluck(:id)
    assert_includes(menu_ids, menu1.id)
    assert_includes(menu_ids, menu2.id)
  end
end
