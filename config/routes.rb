Rails.application.routes.draw do
  namespace :knowledge_base, path: "knowledge-base" do
    root "categories#index"

    resources :categories, only: %i[index new create show] do
      resources :articles, only: %i[new create]
    end

    resources :articles, only: %i[show edit update]
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
  # root "posts#index"
  resources :tickets do
    resources :messages, only: :create
  end

  resources :contacts, only: %i[index show]
  root "tickets#index"
end
