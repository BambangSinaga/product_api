RSpec.describe 'Api::V1::ProductsController', type: :request do
  let!(:products) { FactoryBot.create_list(:product, 10) }
  let(:product_id) { products.first.id }

  describe 'GET /produts' do
    # make HTTP get request before each example
    before { get api_v1_products_path }

    it 'returns products' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /products/:id' do
    before { get api_v1_product_path(product_id) }

    context 'when the record exists' do
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to eql "{\"message\":\"Couldn't find Product with 'id'=100\"}"
      end
    end
  end

  describe 'POST /products' do
    let(:valid_attributes) do
      { name: 'pizza', price: 10_000, email: 'test@mail.com', category: 'desert' }
    end

    context 'when the request is valid' do
      before { post api_v1_products_path, params: valid_attributes }

      it 'creates a product' do
        expect(json['name']).to eq('pizza')
        expect {
          UpdateProductStatusJob.perform_later(json['id'])
        }.to have_enqueued_job
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_products_path, params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to eql "{\"message\":\"Validation failed: Price can't be blank, Category can't be blank, Email can't be blank, Email Email invalid\"}"
      end
    end
  end

  describe 'PUT /products/:id' do
    let(:valid_attributes) { { name: 'lasagna' } }

    context 'when the record exists' do
      before { put api_v1_product_path(product_id), params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /product/:id' do
    before { delete api_v1_product_path(product_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end