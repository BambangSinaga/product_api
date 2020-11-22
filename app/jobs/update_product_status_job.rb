class UpdateProductStatusJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find(product_id)
  end
end