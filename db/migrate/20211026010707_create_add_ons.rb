class CreateAddOns < ActiveRecord::Migration[6.1]
  def change
    create_table :add_ons do |t|
      t.string :name
      t.belongs_to :menu_item, index: true

      t.timestamps
    end
  end
end
