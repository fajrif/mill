require 'rails_helper'

RSpec.describe 'Public::Projects', type: :request do
  let!(:project) { create(:project) }

  describe 'GET /projects' do
    it 'returns a successful response' do
      get projects_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all projects' do
      project2 = create(:project, name: 'Modern House')
      get projects_path
      expect(response.body).to include(project.name)
      expect(response.body).to include(project2.name)
    end

    context 'with pagination' do
      before do
        15.times { create(:project) }
      end

      it 'paginates projects' do
        get projects_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /projects/:id' do
    it 'returns a successful response' do
      get project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'displays the project details' do
      get project_path(project)
      expect(response.body).to include(project.name)
    end

    context 'with slug' do
      it 'can be accessed by slug' do
        get project_path(project.slug)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
