Rails.application.routes.draw do
  root 'users#index'
  
  get         '/signup', to: 'users#new'
  post        '/signup', to: 'users#create'
  get   '/users/search', to: 'users#search'
  get    '/users/:slug', to: 'users#show',      as: 'user_show'
  get          '/login', to: 'sessions#new'
  post         '/login', to: 'sessions#create'
  delete      '/logout', to: 'sessions#destroy'
end
