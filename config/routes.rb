Rails.application.routes.draw do

  get 'bases/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    collection { post :import }
    get 'search', to: 'users#search'
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'start_employee'
      get 'approvals/index_approvals'
      get 'attendances/index_over_time'
      get 'attendances/index_one_month'
      get 'attendances/index_approval_log'
    end
    resources :attendances, only: :update do
      member do
      get 'edit_overtime'
      patch 'update_overtime'
      patch 'over_update'
      patch 'one_month_approval_update'
      end
    end
    
    resources :approvals do 
      member do
        patch 'approval_update'
      end
    end
  end
     resources :bases
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
