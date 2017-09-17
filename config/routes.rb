Rails.application.routes.draw do
  devise_for :users, controllers: {
  	sessions: 'users/sessions'
  }
  resources :songs
  resources :animes
  get 'anime/index'
  get 'song/index'
  get 'anime/show'

  
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
