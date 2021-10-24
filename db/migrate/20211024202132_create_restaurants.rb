class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name

      t.timestamps
    end

    add_reference :menus, :restaurant, index: true
  end
end
