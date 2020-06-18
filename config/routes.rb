Rails.application.routes.draw do

  root 'static_pages#top'
  post '/callback' => 'linebot#callback'
  get '/signup', to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
