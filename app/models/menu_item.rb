class MenuItem < ApplicationRecord
  has_and_belongs_to_many :menus, join_table: 'menu_menu_items'
  has_many :add_ons

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :name, uniqueness: true
end
