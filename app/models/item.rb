class Item < ApplicationRecord
  belongs_to :cart, optional: true
  has_one :product
  belongs_to :order, optional: true

end
