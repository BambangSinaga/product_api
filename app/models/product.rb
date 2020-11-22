class Product < ApplicationRecord
  validates :name, :price, :category, :email, presence: true
end
