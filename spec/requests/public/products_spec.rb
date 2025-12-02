require 'rails_helper'

RSpec.describe 'Public::Products', type: :request do
  let!(:product) { create(:product) }

  describe 'GET /products' do
    it 'returns a successful response' do
      get products_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all products' do
      product2 = create(:product, name: 'Fix Window Series')
      get products_path
      expect(response.body).to include(product.name)
      expect(response.body).to include(product2.name)
    end

    context 'with pagination' do
      before do
        20.times { create(:product) }
      end

      it 'paginates products' do
        get products_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /products/:id' do
    it 'returns a successful response' do
      get product_path(product)
      expect(response).to have_http_status(:success)
    end

    it 'displays the product details' do
      get product_path(product)
      expect(response.body).to include(product.name)
    end

    context 'with slug' do
      it 'can be accessed by slug' do
        get product_path(product.slug)
        expect(response).to have_http_status(:success)
      end
    end

    context 'with non-existent product' do
      it 'returns 404 not found' do
        get product_path('non-existent-product')
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
