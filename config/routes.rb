Rails.application.routes.draw do
  #ユーザー用デバイス
  devise_for :users,skip: [:passwords], controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions'
}

  #管理者用デバイス
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: 'admin/sessions'
}

  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'

  resources :access_logs, only: [:create]

  #ユーザー用ルート
  scope module: :public do
    get '/users/mypage' => 'users#mypage'
    get '/users/information/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    get '/users/check' => 'users#check'
    patch '/users/withdraw' => 'users#withdraw'

    get '/search' => 'searches#search'

    resources :materials do
      resource :favorite, only: [:create, :destroy]
      resource :bookmark, only: [:create, :destroy]
      resources :reports, only: [:new, :create]
      resources :comments, only: [:new, :create, :destroy] do
        resources :reports, only: [:new, :create]
      end

      #比較用ルーティング
      collection do
        get 'compare'
      end
    end

    resources :genres, only: [:show]
    resources :notifications, only: [:update]
  end

  #管理者用ルート
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :reports, only: [:index, :show, :update]
    resources :materials, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :access_logs, only: [:index]
  end

end
