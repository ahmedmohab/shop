class Product < ApplicationRecord
    belongs_to :productcategory
    has_many :orders
end
