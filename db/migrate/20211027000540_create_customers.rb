class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name

      t.timestamps
    end

    add_reference :orders, :customer, index: true
  end
end
