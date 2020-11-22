class UpdateProductStatusJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find(product_id)
    product.update(is_status: true)
    ProductMailer.add_product_success(product).deliver_now
  end
end