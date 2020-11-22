class UpdateProductStatusJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    ProductMailer.add_product_success(product_id).deliver_later
  end
end