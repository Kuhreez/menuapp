class MenusMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_menu_items, id: false do |t|
      t.integer :menu_id
      t.integer :menu_item_id
    end

    # In practice, we might want to do this in phases so that we have the join table
    # synced up with the existing relations, and then remove the menu_id column
    # after everything has been synced up.

    add_index :menu_menu_items,
              [:menu_id, :menu_item_id],
              unique: true,
              name: 'index_menu_menu_items_on_menu_id_and_menu_item_id'

    remove_column :menu_items, :menu_id, :integer
  end
end
