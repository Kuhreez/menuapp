require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  test 'Menus have title' do
    menu1 = Menu.create(title: 'Appetizers')
    menu2 = Menu.create(title: 'Boiled Seafood')
    assert_equal(menu1.title, 'Appetizers')
    assert_equal(menu2.title, 'Boiled Seafood')
  end

  test 'Menu can have multiple menu items' do
    restaurant = Restaurant.create(name: 'Super Cajun Seafood')
    menu = Menu.create(title: 'Beverages', restaurant_id: restaurant.id)
    item1 = MenuItem.create(
      name: 'Coke',
      description: 'Refreshing soda from the Coca-Cola company',
      price: 1.50
    )
    item2 = MenuItem.create(
      name: 'Bottle Water',
      description: 'Good old Dihydrogen Oxide',
      price: 1.00
    )
    menu.menu_items << item1
    menu.menu_items << item2
    menu.save
    item_ids = menu.menu_items.pluck(:id)
    assert_includes(item_ids, item1.id)
    assert_includes(item_ids, item2.id)
  end
end
