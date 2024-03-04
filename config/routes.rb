Rails.application.routes.draw do
  resources :resource_links, except: %i[show index]

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'login' => 'sessions#destroy'
  
  resources :users, except: %i[index destroy create new]
  resources :todo_items, except: %i[index show edit update] do
    post :flip, on: :member
  end
  resources :entries, except: %i[index show]
  resources :projects do
    get :details, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "application#index"
end
