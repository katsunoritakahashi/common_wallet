Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create destroy show]
  resources :months, only: %i[new index create destroy edit update], shallow: true do
    resources :details, only: %i[index create destroy update new]
    resources :budgets, only: %i[index create destroy]
    resources :deposits, only: %i[index create destroy], shallow: true do
      resources :corrects, only: %i[index create destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
