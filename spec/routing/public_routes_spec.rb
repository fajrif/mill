require 'rails_helper'

RSpec.describe 'Public routes', type: :routing do
  describe 'root route' do
    it 'routes to home#index' do
      expect(get: '/').to route_to('home#index')
    end
  end

  describe 'about route' do
    it 'routes to home#about' do
      expect(get: '/about').to route_to('home#about')
    end
  end

  describe 'products routes' do
    it 'routes to products#index' do
      expect(get: '/products').to route_to('products#index')
    end

    it 'routes to products#show' do
      expect(get: '/products/swing-series').to route_to('products#show', id: 'swing-series')
    end
  end

  describe 'projects routes' do
    it 'routes to projects#index' do
      expect(get: '/projects').to route_to('projects#index')
    end

    it 'routes to projects#show' do
      expect(get: '/projects/luxury-home').to route_to('projects#show', id: 'luxury-home')
    end
  end

  describe 'articles routes' do
    it 'routes to articles#index' do
      expect(get: '/articles').to route_to('articles#index')
    end

    it 'routes to articles#show' do
      expect(get: '/articles/test-article').to route_to('articles#show', id: 'test-article')
    end
  end

  describe 'events routes' do
    it 'routes to events#index' do
      expect(get: '/events').to route_to('events#index')
    end

    it 'routes to events#show' do
      expect(get: '/events/test-event').to route_to('events#show', id: 'test-event')
    end
  end

  describe 'contact routes' do
    it 'routes to contacts#show' do
      expect(get: '/contact').to route_to('contacts#show')
    end

    it 'routes to contacts#create' do
      expect(post: '/contact').to route_to('contacts#create')
    end
  end
end
