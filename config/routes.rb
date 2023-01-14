Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    # ※resources →　resource 「s」をなくすことで、URLに/:idが含まれなくなる。
    # いいね機能は1人のユーザーが1つの投稿にいいねを押すことが出来るのが１回のみなのでURLにparams[:id]を使わなくても良いので「ｓ」を無くした書き方にしている。
  end
  resources :users, only: [:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end