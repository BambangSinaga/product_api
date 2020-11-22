class ProductMailer < ApplicationMailer
  def add_product_success(product)
    @product = product
    mail(to: @product.email, subject: 'Produk berhasil ditambahkan')
  end
end
