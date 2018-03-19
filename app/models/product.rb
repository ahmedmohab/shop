class Product < ApplicationRecord
    belongs_to :category
    has_many :items
    has_many :orders
end
