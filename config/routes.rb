Rails.application.routes.draw do

  root to: 'static_pages#home'

  get '/home', to: 'static_pages#home'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  resources :users, except: [:create,:new, :index] do
    #resources :orders, only: [:index]
  end

=begin
  resource :orders, only: [:show]

  get '/cart', to: 'orders#edit'

  post '/cart', to: 'orders#update'

  resources :stores, only: [:index, :show]

  resources :items, only: [:index, :show]


  namespace :owner do
    resources :stores, except: [:index, :show, :new, :create] do
      resources :items, except: [:index, :show], shallow: true
      resources :events, shallow: true
    end
  end

  namespace :admin do
    resources :tags
    resources :users, only: [:index]
  end
=end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
