require 'rails_helper'

RSpec.describe 'Admins::Articles', type: :request do
  let(:admin) { create(:admin) }
  let(:category) { create(:category) }
  let!(:article) { create(:article, category: category) }

  before do
    sign_in admin
  end

  describe 'GET /admins/articles' do
    it 'returns a successful response' do
      get admins_articles_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all articles' do
      article2 = create(:article, title: 'Second Article')
      get admins_articles_path
      expect(response.body).to include(article.title)
      expect(response.body).to include(article2.title)
    end
  end

  describe 'GET /admins/articles/:id' do
    it 'returns a successful response' do
      get admins_article_path(article)
      expect(response).to have_http_status(:success)
    end

    it 'displays the article details' do
      get admins_article_path(article)
      expect(response.body).to include(article.title)
    end
  end

  describe 'GET /admins/articles/new' do
    it 'returns a successful response' do
      get new_admins_article_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the new article form' do
      get new_admins_article_path
      expect(response.body).to include('form')
    end
  end

  describe 'POST /admins/articles' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          title: 'New Article',
          short_description: 'Short description',
          category_id: category.id,
          status: 1,
          published_date: Date.today,
          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')
        }
      end

      it 'creates a new article' do
        expect {
          post admins_articles_path, params: { article: valid_attributes }
        }.to change(Article, :count).by(1)
      end

      it 'redirects to the article index or show page' do
        post admins_articles_path, params: { article: valid_attributes }
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

      it 'does not create a new article' do
        expect {
          post admins_articles_path, params: { article: invalid_attributes }
        }.not_to change(Article, :count)
      end

      it 'returns unprocessable entity status' do
        post admins_articles_path, params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /admins/articles/:id/edit' do
    it 'returns a successful response' do
      get edit_admins_article_path(article)
      expect(response).to have_http_status(:success)
    end

    it 'displays the edit form with article data' do
      get edit_admins_article_path(article)
      expect(response.body).to include(article.title)
    end
  end

  describe 'PATCH /admins/articles/:id' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: 'Updated Article Title',
          short_description: 'Updated description'
        }
      end

      it 'updates the article' do
        patch admins_article_path(article), params: { article: new_attributes }
        article.reload
        expect(article.title).to eq('Updated Article Title')
        expect(article.short_description).to eq('Updated description')
      end

      it 'redirects to the article' do
        patch admins_article_path(article), params: { article: new_attributes }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          title: ''
        }
      end

      it 'does not update the article' do
        original_title = article.title
        patch admins_article_path(article), params: { article: invalid_attributes }
        article.reload
        expect(article.title).to eq(original_title)
      end

      it 'returns unprocessable entity status' do
        patch admins_article_path(article), params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /admins/articles/:id' do
    it 'destroys the article' do
      article_to_delete = create(:article)
      expect {
        delete admins_article_path(article_to_delete)
      }.to change(Article, :count).by(-1)
    end

    it 'redirects to articles list' do
      delete admins_article_path(article)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'authentication requirement' do
    before do
      sign_out admin
    end

    it 'requires authentication for index' do
      get admins_articles_path
      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'requires authentication for create' do
      post admins_articles_path, params: { article: { title: 'Test' } }
      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'requires authentication for update' do
      patch admins_article_path(article), params: { article: { title: 'Updated' } }
      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'requires authentication for destroy' do
      delete admins_article_path(article)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
