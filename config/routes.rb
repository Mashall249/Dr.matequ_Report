Rails.application.routes.draw do
  #ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  #管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :materials, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:destroy]
  end

  scope module: :public do
    get '/users/mypage' => 'users#mypage'
    get '/users/check' => 'users#check'
    patch '/users/withdraw' => 'users#withdraw'

    resources :users, only: [:edit, :update]
    resources :materials
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end
