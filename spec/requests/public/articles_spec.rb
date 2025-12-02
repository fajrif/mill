require 'rails_helper'

RSpec.describe 'Public::Articles', type: :request do
  let(:category) { create(:category) }
  let!(:article) { create(:article, category: category) }

  describe 'GET /articles' do
    it 'returns a successful response' do
      get articles_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all articles' do
      article2 = create(:article, title: 'Second Article', category: category)
      get articles_path
      expect(response.body).to include(article.title)
      expect(response.body).to include(article2.title)
    end

    context 'with pagination' do
      before do
        10.times { create(:article, category: category) }
      end

      it 'paginates articles' do
        get articles_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /articles/:id' do
    it 'returns a successful response' do
      get article_path(article)
      expect(response).to have_http_status(:success)
    end

    it 'displays the article details' do
      get article_path(article)
      expect(response.body).to include(article.title)
    end

    context 'with slug' do
      it 'can be accessed by slug' do
        get article_path(article.slug)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
