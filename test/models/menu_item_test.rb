require 'test_helper'

class MenuItemTest < ActiveSupport::TestCase
  test 'Menu item cannot cost less than 0' do
    assert_raises(ActiveRecord::RecordInvalid) do
      MenuItem.create!(
        name: 'Coke',
        description: 'Refreshing soda from the Coca-Cola company',
        price: -1.00
      )
    end
  end

  test 'Menu item can belong to multiple menus' do
    restaurant = Restaurant.create(name: 'Super Cajun Seafood')
    menu1 = Menu.create(title: 'Appetizers', restaurant_id: restaurant.id)
    menu2 = Menu.create(title: 'Chef Recommendation', restaurant_id: restaurant.id)
    item = MenuItem.create(
      name: 'Hush Puppies',
      description: 'Small, savoury, deep-fried round ball made from cornmeal-based batter',
      price: 3.00
    )

    item.menus << menu1
    item.menus << menu2
    item.save

    menu_ids = item.menus.pluck(:id)
    assert_includes(menu_ids, menu1.id)
    assert_includes(menu_ids, menu2.id)
  end

  test 'Menu item names are unique' do
    item = MenuItem.create(
      name: 'Hush Puppies',
      description: 'Small, savoury, deep-fried round ball made from cornmeal-based batter',
      price: 3.00
    )

    assert_raises(ActiveRecord::RecordInvalid) do
      MenuItem.create!(
        name: 'Hush Puppies',
        description: 'Copy Cat Hush Puppies',
        price: 4.00
      )
    end
  end
end
