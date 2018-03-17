class Cart < ApplicationRecord
  belongs_to :product
  has_one :user
    
    def add_item(product_id)
  item = items.where('product_id = ?', product_id).first
  if item
    # increase the quantity of product in cart
    item.quantity + 1
    save
  else
    # product does not exist in cart
    cart.items << Item.new(product_id: product_id, quantity: 1)
  end
  save
end
end
