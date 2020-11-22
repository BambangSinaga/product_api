class Product < ApplicationRecord
  has_one_attached :image

  validates :name, :price, :category, :email, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalid"  },
            uniqueness: { case_sensitive: false }

  def image_url
    return Rails.application.routes.url_helpers.url_for(image) if image.attached?
    ''
  end
end
