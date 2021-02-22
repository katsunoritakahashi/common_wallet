Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create destroy show]
  resources :months, only: %i[index new create destroy show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
