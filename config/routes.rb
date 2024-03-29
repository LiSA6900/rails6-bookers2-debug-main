Rails.application.routes.draw do
  get 'event_notices/new'
  get 'event_notices/create'
  get 'event_notices/sent'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    # ※resources → resource 「s」をなくすことで、URLに/:idが含まれなくなる。
    # いいね機能は1人のユーザーが1つの投稿にいいねを押すことが出来るのが１回のみなのでURLにparams[:id]を使わなくても良いので「ｓ」を無くした書き方にしている。
  end
  resources :users, only: [:index,:show,:edit,:update] do
    # ネストさせる
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "daily_posts" => 'users#daily_posts'
  end
  
  get '/search', to: 'searches#search'
  
  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end
  
  resources :chats, only: [:show, :create]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end