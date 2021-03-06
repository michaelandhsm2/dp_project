Rails.application.routes.draw do

  root to: 'static_pages#home'

  get '/home', to: 'static_pages#home'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :show, :new, :create, :destroy] do
    resources :orders, only: [:index]
  end

  resources :orders, only: [:index, :show, :update ]

  resource :cart, only: [:show]
  get '/cart_confirmation', to: 'carts#confirm'
  post '/cart_confirmation', to: 'carts#submit'

  resources :order_items, only: [:create, :update, :destroy]

  get '/stores/new', to: redirect('/owner/stores/new')
  get '/stores/:id/edit', to: redirect('/owner/stores/%{id}/edit')

  resources :stores, only: [:index, :show]
  get '/items', to: 'items#catalog'
  get '/stores/:store_id/items', to: 'items#index'
  get '/items/:id', to: 'items#show'

  resources :tags, only: [:show, :index], param: :label

  get '/back', to: 'orders#back'

  resources :events, only: [:show]

  namespace :owner do
    resources :events, except: [:new,:show]
    get '/events/new/:type', to: 'events#new'
    resources :stores, except: [:index, :show] do
      resources :items, except: [:index, :show], shallow: true
    end

    resources :orders, only: [:index, :show, :update ]


    get '/items', to: redirect('/items')
    get '/stores/:store_id/items', to: redirect('/stores/%{store_id}/items')
    get '/stores/:store_id/items/:item_id', to: 'items#show'
    post '/stores/:store_id/items/:item_id', to: 'items#update'
    get '/items/:id', to: redirect('/items/%{id}')
    get '/stores', to: redirect('/stores')
    get '/stores/:id', to: redirect('/stores/%{id}')
  end

  namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :orders, only: [:index, :show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
