require 'rails_helper'

RSpec.describe 'Admins::Projects', type: :request do
  let(:admin) { create(:admin) }
  let!(:project) { create(:project) }

  before do
    sign_in admin
  end

  describe 'GET /admins/projects' do
    it 'returns a successful response' do
      get admins_projects_path
      expect(response).to have_http_status(:success)
    end

    it 'displays all projects' do
      project2 = create(:project, name: 'Modern House')
      get admins_projects_path
      expect(response.body).to include(project.name)
      expect(response.body).to include(project2.name)
    end
  end

  describe 'GET /admins/projects/:id' do
    it 'returns a successful response' do
      get admins_project_path(project)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /admins/projects' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          name: 'Luxury Villa',
          client_name: 'John Doe',
          caption: 'Premium villa project',
          short_description: 'A beautiful luxury villa',
          description: 'Detailed description of the project',
          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg'),
          banner: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_banner.jpg'), 'image/jpeg')
        }
      end

      it 'creates a new project' do
        expect {
          post admins_projects_path, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
      end

      it 'creates project with client_name' do
        post admins_projects_path, params: { project: valid_attributes }
        new_project = Project.last
        expect(new_project.client_name).to eq('John Doe')
      end

      it 'redirects after creation' do
        post admins_projects_path, params: { project: valid_attributes }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          name: '',
          client_name: ''
        }
      end

      it 'does not create a new project' do
        expect {
          post admins_projects_path, params: { project: invalid_attributes }
        }.not_to change(Project, :count)
      end
    end
  end

  describe 'PATCH /admins/projects/:id' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Updated Project Name',
          client_name: 'Jane Smith',
          caption: 'Updated caption'
        }
      end

      it 'updates the project' do
        patch admins_project_path(project), params: { project: new_attributes }
        project.reload
        expect(project.name).to eq('Updated Project Name')
        expect(project.client_name).to eq('Jane Smith')
      end

      it 'updates the slug' do
        original_slug = project.slug
        patch admins_project_path(project), params: { project: { name: 'New Project Name' } }
        project.reload
        expect(project.slug).not_to eq(original_slug)
        expect(project.slug).to eq('new-project-name')
      end
    end
  end

  describe 'DELETE /admins/projects/:id' do
    it 'destroys the project' do
      project_to_delete = create(:project)
      expect {
        delete admins_project_path(project_to_delete)
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to projects list' do
      delete admins_project_path(project)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'authentication requirement' do
    before do
      sign_out admin
    end

    it 'requires authentication for all actions' do
      get admins_projects_path
      expect(response).to redirect_to(new_admin_session_path)

      post admins_projects_path, params: { project: { name: 'Test' } }
      expect(response).to redirect_to(new_admin_session_path)

      patch admins_project_path(project), params: { project: { name: 'Updated' } }
      expect(response).to redirect_to(new_admin_session_path)

      delete admins_project_path(project)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
