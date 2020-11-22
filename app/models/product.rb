class Product < ApplicationRecord
  validates :name, :price, :category, :email, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalid"  },
            uniqueness: { case_sensitive: false }
end
