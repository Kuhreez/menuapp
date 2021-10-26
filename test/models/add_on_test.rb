require 'test_helper'

class AddOnTest < ActiveSupport::TestCase
  test 'Menu item can have multiple add ons' do
    item = MenuItem.create(
      name: 'Caesar Salad',
      description: "Rumor has it that this was Julius Caesar's favorite dish!",
      price: 4.50
    )

    add_on1 = AddOn.create(name: 'Ranch', menu_item_id: item.id)
    add_on2 = AddOn.create(name: 'Blue Cheese', menu_item_id: item.id)
    add_on3 = AddOn.create(name: 'Honey Mustard', menu_item_id: item.id)

    add_on_ids = item.add_ons.pluck(:id)
    assert_includes(add_on_ids, add_on1.id)
    assert_includes(add_on_ids, add_on2.id)
    assert_includes(add_on_ids, add_on3.id)
  end
end
