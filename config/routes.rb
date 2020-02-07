Rails.application.routes.draw do

  get 'bases/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    get 'search', to: 'users#search'
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'start_employee'
    end
    resources :attendances do
      member do
        patch 'update'
        get 'edit_overtime'
        patch 'update_overtime'
      end
    end
  end
  resources :bases
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
