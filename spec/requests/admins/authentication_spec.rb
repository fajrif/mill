require 'rails_helper'

RSpec.describe 'Admin Authentication', type: :request do
  let(:admin) { create(:admin) }

  describe 'GET /admins/sign_in' do
    it 'returns a successful response' do
      get new_admin_session_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the sign in form' do
      get new_admin_session_path
      expect(response.body).to include('sign')
    end
  end

  describe 'POST /admins/sign_in' do
    context 'with valid credentials' do
      it 'logs in the admin' do
        post admin_session_path, params: {
          admin: {
            email: admin.email,
            password: 'password123'
          }
        }
        expect(response).to have_http_status(:redirect)
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the admin' do
        post admin_session_path, params: {
          admin: {
            email: admin.email,
            password: 'wrongpassword'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with non-existent email' do
      it 'does not log in' do
        post admin_session_path, params: {
          admin: {
            email: 'nonexistent@example.com',
            password: 'password123'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /admins/sign_out' do
    before do
      sign_in admin
    end

    it 'logs out the admin' do
      delete destroy_admin_session_path
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Admin protected routes' do
    context 'when not authenticated' do
      it 'redirects to sign in page' do
        get admins_root_path
        expect(response).to redirect_to(new_admin_session_path)
      end
    end

    context 'when authenticated' do
      before do
        sign_in admin
      end

      it 'allows access to admin dashboard' do
        get admins_root_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
