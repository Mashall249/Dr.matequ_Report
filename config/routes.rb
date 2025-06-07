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

  #ユーザー用ルート
  scope module: :public do
    get '/users/mypage' => 'users#mypage'
    get '/users/information/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    get '/users/check' => 'users#check'
    patch '/users/withdraw' => 'users#withdraw'

    get '/search' => 'searches#search'

    resources :materials do

      resources :comments, only: [:new, :create, :destroy] do
        resources :reports, only: [:new, :create]
      end

      resource :favorite, only: [:create, :destroy]
      resources :reports, only: [:new, :create]
    end

    resources :genres, only: [:show]
    resources :notifications, only: [:update]
  end

  #管理者用ルート
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :materials, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

end
