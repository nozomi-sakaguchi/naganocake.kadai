class Item < ApplicationRecord

belongs_to :customer
  has_many :order_items
  belongs_to :genre
  has_many :order_items

end
