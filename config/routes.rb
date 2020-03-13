# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'

  get                    '/signup', to: 'users#new',               as: 'signup'
  post                   '/signup', to: 'users#create'

  get                     '/login', to: 'sessions#new'
  post                    '/login', to: 'sessions#create'
  delete                 '/logout', to: 'sessions#destroy'

  get              '/users/search', to: 'users#search'
  get     '/users/:username/:slug', to: 'users#connection',         as: 'user_connections'
  post         '/users/follow/:id', to: 'users#follow',             as: 'follow_user'
  post       '/users/unfollow/:id', to: 'users#unfollow',           as: 'unfollow_user'
  get               '/users/:slug', to: 'users#show',               as: 'user_show'

  post               '/microposts', to: 'microposts#create',        as: 'create_post'
  get          '/microposts/:slug', to: 'microposts#user_posts',    as: 'display_user_posts'
  get                '/microposts', to: 'microposts#all_posts',     as: 'display_all_posts'
end
