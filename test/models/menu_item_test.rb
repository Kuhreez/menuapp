require 'test_helper'

class MenuItemTest < ActiveSupport::TestCase
  test 'Menu item cannot cost less than 0' do
    menu = Menu.create(title: 'Beverages')
    assert_raises(ActiveRecord::RecordInvalid) do
      MenuItem.create!(
        name: 'Coke',
        description: 'Refreshing soda from the Coca-Cola company',
        price: -1.00,
        menu_id: menu.id
      )
    end
  end

  test 'Menu item belongs to a menu' do
    menu = Menu.create(title: 'Appetizers')
    item = MenuItem.create!(
      name: 'Hush Puppies',
      description: 'Small, savoury, deep-fried round ball made from cornmeal-based batter',
      price: 3.00,
      menu_id: menu.id
    )

    assert_equal(item.menu.id, menu.id)
  end
end
