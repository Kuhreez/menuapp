class Menu < ApplicationRecord
  has_many :menu_items
  belongs_to :restaurant
end
