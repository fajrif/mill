require 'rails_helper'

RSpec.describe 'Admins::Products', type: :request do
  let(:admin) { create(:admin) }
  let!(:product) { create(:product) }

  before do
    sign_in admin
  end

  describe 'GET /admins/products' do
    it 'returns a successful response' do
      get admins_products_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all products' do
      product2 = create(:product, name: 'Fix Window Series')
      get admins_products_path
      expect(response.body).to include(product.name)
      expect(response.body).to include(product2.name)
    end
  end

  describe 'GET /admins/products/:id' do
    it 'returns a successful response' do
      get admins_product_path(product)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /admins/products' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          name: 'Sliding Series',
          caption: 'Premium sliding doors',
          short_description: 'High quality sliding solutions',
          description: 'Detailed description of the product',
          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg'),
          banner: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_banner.jpg'), 'image/jpeg')
        }
      end

      it 'creates a new product' do
        expect {
          post admins_products_path, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirects after creation' do
        post admins_products_path, params: { product: valid_attributes }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          name: '',
          caption: ''
        }
      end

      it 'does not create a new product' do
        expect {
          post admins_products_path, params: { product: invalid_attributes }
        }.not_to change(Product, :count)
      end
    end
  end

  describe 'PATCH /admins/products/:id' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Updated Product Name',
          caption: 'Updated caption'
        }
      end

      it 'updates the product' do
        patch admins_product_path(product), params: { product: new_attributes }
        product.reload
        expect(product.name).to eq('Updated Product Name')
        expect(product.caption).to eq('Updated caption')
      end

      it 'updates the slug' do
        patch admins_product_path(product), params: { product: { name: 'New Name' } }
        product.reload
        expect(product.slug).to eq('new-name')
      end
    end
  end

  describe 'DELETE /admins/products/:id' do
    it 'destroys the product' do
      product_to_delete = create(:product)
      expect {
        delete admins_product_path(product_to_delete)
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to products list' do
      delete admins_product_path(product)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'authentication requirement' do
    before do
      sign_out admin
    end

    it 'requires authentication for all actions' do
      get admins_products_path
      expect(response).to redirect_to(new_admin_session_path)

      post admins_products_path, params: { product: { name: 'Test' } }
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
