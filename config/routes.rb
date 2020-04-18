Rails.application.routes.draw do
  root 'user_sessions#new'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  get 'twitter_lists/update_index' => 'twitter_lists#update_index'
  resources :twitter_lists, param: :access_id, only: %w[index show]
  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'
end
