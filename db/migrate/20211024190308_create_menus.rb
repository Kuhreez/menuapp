class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :title
      t.timestamps
    end

    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.float :price
      t.belongs_to :menu, index: true, foreign_key: true
      t.timestamps
    end
  end
end
