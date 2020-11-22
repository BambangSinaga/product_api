class ProductMailer < ApplicationMailer
  def add_product_success(product_id)
    @product = Product.find(product_id)
    mail(to: @product.email, subject: 'Produk berhasil ditambahkan')
  end
end
