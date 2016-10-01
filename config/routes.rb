Rails.application.routes.draw do
  resources :webdata

  post '/api/webdata', to: 'webdata#api_create'

  root :to => 'pages#index'
  get '/core', to: 'pages#core', defaults: {format: 'js'}


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
