require 'rails_helper'

RSpec.describe 'Public::Events', type: :request do
  let!(:event) { create(:event) }

  describe 'GET /events' do
    it 'returns a successful response' do
      get events_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all events' do
      event2 = create(:event, title: 'Second Event')
      get events_path
      expect(response.body).to include(event.title)
      expect(response.body).to include(event2.title)
    end

    context 'with pagination' do
      before do
        10.times { create(:event) }
      end

      it 'paginates events' do
        get events_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /events/:id' do
    it 'returns a successful response' do
      get event_path(event)
      expect(response).to have_http_status(:success)
    end

    it 'displays the event details' do
      get event_path(event)
      expect(response.body).to include(event.title)
    end

    context 'with slug' do
      it 'can be accessed by slug' do
        get event_path(event.slug)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
