Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admins, :controllers => { :sessions => "admins/sessions" }

  namespace :admins do
    root :to => 'dashboard#index'
    get "account/change_password" => "accounts#change_password", :as => :change_password
    put "account/update_password" => "accounts#update_password", :as => :update_password

    resources :articles do
      member do
        delete "delete_attachment/:asset_id" => "articles#delete_attachment", :as => :delete_attachment
        delete "delete_attachment_image/:asset_id" => "articles#delete_attachment_image", :as => :delete_attachment_image
      end
    end
    resources :events do
      member do
        delete "delete_attachment_image/:asset_id" => "events#delete_attachment_image", :as => :delete_attachment_image
      end
    end
    resources :categories
    resources :questions
    resources :testimonials
    resources :contacts
    resources :features
    resources :products
    resources :projects
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # i18n Scope for id
  resources :products, :only => [:index, :show]
  resources :projects, :only => [:index, :show]
  resources :articles, :only => [:index, :show]
  resources :events, :only => [:index, :show]
  resource :contact, :only => [:show, :create]

  match 'about', to: 'home#about', via: :get, as: :about

  root :to => "home#index"
end
