Rails.application.routes.draw do
  # NOTE: 恐らく下記2行不要
  # get 'oauths/oauth'
  # get 'oauths/callback'
  root 'users#new'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
end
