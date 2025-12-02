require 'rails_helper'

RSpec.describe 'Admin routes', type: :routing do
  describe 'devise routes' do
    it 'routes to admins sessions' do
      expect(get: '/admins/sign_in').to route_to('admins/sessions#new')
      expect(post: '/admins/sign_in').to route_to('admins/sessions#create')
      expect(delete: '/admins/sign_out').to route_to('admins/sessions#destroy')
    end
  end

  describe 'admin dashboard' do
    it 'routes to admins/dashboard#index' do
      expect(get: '/admins').to route_to('admins/dashboard#index')
    end
  end

  describe 'admin articles routes' do
    it 'routes to admins/articles#index' do
      expect(get: '/admins/articles').to route_to('admins/articles#index')
    end

    it 'routes to admins/articles#new' do
      expect(get: '/admins/articles/new').to route_to('admins/articles#new')
    end

    it 'routes to admins/articles#create' do
      expect(post: '/admins/articles').to route_to('admins/articles#create')
    end

    it 'routes to admins/articles#show' do
      expect(get: '/admins/articles/1').to route_to('admins/articles#show', id: '1')
    end

    it 'routes to admins/articles#edit' do
      expect(get: '/admins/articles/1/edit').to route_to('admins/articles#edit', id: '1')
    end

    it 'routes to admins/articles#update' do
      expect(patch: '/admins/articles/1').to route_to('admins/articles#update', id: '1')
    end

    it 'routes to admins/articles#destroy' do
      expect(delete: '/admins/articles/1').to route_to('admins/articles#destroy', id: '1')
    end
  end

  describe 'admin events routes' do
    it 'routes to admins/events CRUD actions' do
      expect(get: '/admins/events').to route_to('admins/events#index')
      expect(post: '/admins/events').to route_to('admins/events#create')
      expect(get: '/admins/events/1').to route_to('admins/events#show', id: '1')
      expect(patch: '/admins/events/1').to route_to('admins/events#update', id: '1')
      expect(delete: '/admins/events/1').to route_to('admins/events#destroy', id: '1')
    end
  end

  describe 'admin products routes' do
    it 'routes to admins/products CRUD actions' do
      expect(get: '/admins/products').to route_to('admins/products#index')
      expect(post: '/admins/products').to route_to('admins/products#create')
      expect(get: '/admins/products/1').to route_to('admins/products#show', id: '1')
      expect(patch: '/admins/products/1').to route_to('admins/products#update', id: '1')
      expect(delete: '/admins/products/1').to route_to('admins/products#destroy', id: '1')
    end
  end

  describe 'admin projects routes' do
    it 'routes to admins/projects CRUD actions' do
      expect(get: '/admins/projects').to route_to('admins/projects#index')
      expect(post: '/admins/projects').to route_to('admins/projects#create')
      expect(get: '/admins/projects/1').to route_to('admins/projects#show', id: '1')
      expect(patch: '/admins/projects/1').to route_to('admins/projects#update', id: '1')
      expect(delete: '/admins/projects/1').to route_to('admins/projects#destroy', id: '1')
    end
  end

  describe 'admin features routes' do
    it 'routes to admins/features CRUD actions' do
      expect(get: '/admins/features').to route_to('admins/features#index')
      expect(post: '/admins/features').to route_to('admins/features#create')
      expect(get: '/admins/features/1').to route_to('admins/features#show', id: '1')
      expect(patch: '/admins/features/1').to route_to('admins/features#update', id: '1')
      expect(delete: '/admins/features/1').to route_to('admins/features#destroy', id: '1')
    end
  end

  describe 'admin categories routes' do
    it 'routes to admins/categories CRUD actions' do
      expect(get: '/admins/categories').to route_to('admins/categories#index')
      expect(post: '/admins/categories').to route_to('admins/categories#create')
    end
  end

  describe 'admin contacts routes' do
    it 'routes to admins/contacts actions' do
      expect(get: '/admins/contacts').to route_to('admins/contacts#index')
      expect(get: '/admins/contacts/1').to route_to('admins/contacts#show', id: '1')
    end
  end
end
