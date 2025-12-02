require 'rails_helper'

RSpec.describe 'Public::Home', type: :request do
  describe 'GET /' do
    it 'returns a successful response' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the home page' do
      get root_path
      expect(response.body).to be_present
    end
  end

  describe 'GET /about' do
    it 'returns a successful response' do
      get about_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the about page' do
      get about_path
      expect(response.body).to be_present
    end
  end
end
