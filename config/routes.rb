Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  post '/guest', to: 'guest_sessions#create'
  post '/guest_new', to: 'guests#create'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resource :profile, only: %i[destroy edit update show]
  resources :months, only: %i[new index create destroy edit update], shallow: true do
    resources :details, only: %i[index create destroy update new]
    resources :budgets, only: %i[index create destroy]
    resources :deposits, only: %i[index create destroy], shallow: true do
      resources :corrects, only: %i[index create destroy]
    end
  end
  resources :password_resets, only: %i[new create edit update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
