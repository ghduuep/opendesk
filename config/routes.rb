Rails.application.routes.draw do
  get "home/index"
  namespace :agent do
    root "dashboard#index"

    resources :tickets do
      resources :messages, only: :create
    end

    resources :contacts, only: %i[index show destroy]

    namespace :knowledge_base, path: "knowledge-base" do
      root "categories#index"

      resources :categories, only: %i[index new create show destroy], param: :slug do
        resources :articles, only: %i[new create]
      end

      resources :articles, only: %i[show edit update], param: :slug
    end
  end

  namespace :client do
    root "dashboard#index"

    resources :tickets, only: %i[index show new create] do
      resources :messages, only: :create
    end

    namespace :knowledge_base, path: "knowledge-base" do
      root "categories#index"

      get "search", to: "articles#search"

      resources :categories, only: %i[index show], param: :slug
      resources :articles, only: :show, param: :slug
    end
  end

  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
