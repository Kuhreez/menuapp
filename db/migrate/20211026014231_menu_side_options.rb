class MenuSideOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :includes_side, :boolean
    add_column :menu_items, :is_side, :boolean
  end
end
