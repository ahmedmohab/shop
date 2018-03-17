class User < ApplicationRecord
  include Clearance::User
    has_many :orders
    has_one :cart
end
