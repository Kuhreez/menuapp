class MenuItem < ApplicationRecord
  has_and_belongs_to_many :menus, join_table: "menu_menu_items"
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
