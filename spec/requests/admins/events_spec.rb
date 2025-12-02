require 'rails_helper'

RSpec.describe 'Admins::Events', type: :request do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before do
    sign_in admin
  end

  describe 'GET /admins/events' do
    it 'returns a successful response' do
      get admins_events_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all events' do
      event2 = create(:event, title: 'Second Event')
      get admins_events_path
      expect(response.body).to include(event.title)
      expect(response.body).to include(event2.title)
    end
  end

  describe 'GET /admins/events/:id' do
    it 'returns a successful response' do
      get admins_event_path(event)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /admins/events' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          title: 'New Event',
          short_description: 'Short description',
          status: 1,
          published_date: Date.today + 7.days,
          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')
        }
      end

      it 'creates a new event' do
        expect {
          post admins_events_path, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it 'redirects after creation' do
        post admins_events_path, params: { event: valid_attributes }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          title: '',
          short_description: ''
        }
      end

      it 'does not create a new event' do
        expect {
          post admins_events_path, params: { event: invalid_attributes }
        }.not_to change(Event, :count)
      end
    end
  end

  describe 'PATCH /admins/events/:id' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: 'Updated Event Title',
          short_description: 'Updated description'
        }
      end

      it 'updates the event' do
        patch admins_event_path(event), params: { event: new_attributes }
        event.reload
        expect(event.title).to eq('Updated Event Title')
      end
    end
  end

  describe 'DELETE /admins/events/:id' do
    it 'destroys the event' do
      event_to_delete = create(:event)
      expect {
        delete admins_event_path(event_to_delete)
      }.to change(Event, :count).by(-1)
    end
  end

  describe 'authentication requirement' do
    before do
      sign_out admin
    end

    it 'requires authentication' do
      get admins_events_path
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
