Rails.application.routes.draw do

  get 'resavation/create'

  root 'static_pages#top'
  
    # LINE BOT機能
  post '/callback' => 'linebot#callback'

    # 新規登録機能(parent用)
  get '/signup', to: 'users#new'
    # 新規登録機能(tuter用)
  get '/signup_tutor', to: 'users#new_tutor'   # users#new_tutor
  
    # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get    '/users/info', to: 'users#info'

  resources :users do
    member do
      get 'edit_basic_info'       # /users/:id/edit_basic_info
      patch 'update_basic_info'   # /users/:id/update_basic_info

      # get 'lessons_oneday'        # /users/:id/lessons/oneday  モーダル表示　一日のlesson予約を表示
      # patch 'lessons_oneday'

      get 'lessons/lessons_oneday'        # /users/:id/lessons/lessons_oneday  モーダル表示　tuterが一日のlesson可能時間を編集
      patch 'lessons/update_oneday'       # /users/:id/lessons/update_oneday

      get 'resavation/edit_oneday'        # /users/:id/resavation/edit_oneday(.:format)	resavation#edit_oneday モーダル表示　parentがlessonの予約をする編集画面
      post 'resavation/update_oneday'

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
