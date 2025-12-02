require 'rails_helper'

RSpec.describe 'Admins::Features', type: :request do
  let(:admin) { create(:admin) }
  let!(:feature) { create(:feature) }

  before do
    sign_in admin
  end

  describe 'GET /admins/features' do
    it 'returns a successful response' do
      get admins_features_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all features' do
      feature2 = create(:feature, name: 'Security')
      get admins_features_path
      expect(response.body).to include(feature.name)
      expect(response.body).to include(feature2.name)
    end
  end

  describe 'GET /admins/features/:id' do
    it 'returns a successful response' do
      get admins_feature_path(feature)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /admins/features' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          name: 'Energy Efficiency',
          caption: 'Save energy costs',
          short_description: 'Reduce your energy bills',
          description: 'Detailed description of energy efficiency features',
          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')
        }
      end

      it 'creates a new feature' do
        expect {
          post admins_features_path, params: { feature: valid_attributes }
        }.to change(Feature, :count).by(1)
      end

      it 'redirects after creation' do
        post admins_features_path, params: { feature: valid_attributes }
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

      it 'does not create a new feature' do
        expect {
          post admins_features_path, params: { feature: invalid_attributes }
        }.not_to change(Feature, :count)
      end
    end
  end

  describe 'PATCH /admins/features/:id' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Updated Feature',
          caption: 'Updated caption',
          description: 'Updated description'
        }
      end

      it 'updates the feature' do
        patch admins_feature_path(feature), params: { feature: new_attributes }
        feature.reload
        expect(feature.name).to eq('Updated Feature')
        expect(feature.caption).to eq('Updated caption')
      end
    end
  end

  describe 'DELETE /admins/features/:id' do
    it 'destroys the feature' do
      feature_to_delete = create(:feature)
      expect {
        delete admins_feature_path(feature_to_delete)
      }.to change(Feature, :count).by(-1)
    end

    it 'redirects to features list' do
      delete admins_feature_path(feature)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'authentication requirement' do
    before do
      sign_out admin
    end

    it 'requires authentication for all actions' do
      get admins_features_path
      expect(response).to redirect_to(new_admin_session_path)

      post admins_features_path, params: { feature: { name: 'Test' } }
      expect(response).to redirect_to(new_admin_session_path)

      patch admins_feature_path(feature), params: { feature: { name: 'Updated' } }
      expect(response).to redirect_to(new_admin_session_path)

      delete admins_feature_path(feature)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
