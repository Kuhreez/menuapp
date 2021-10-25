class Menu < ApplicationRecord
  has_and_belongs_to_many :menu_items, join_table: "menu_menu_items"
  belongs_to :restaurant
end
