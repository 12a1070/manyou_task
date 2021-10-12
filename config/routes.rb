Rails.application.routes.draw do
  # アドミン定義
# namespace・・・URLをアドミンをつけた状態で作れる。
  namespace :admin do
# ユーザーにクラッド機能につけることができる
    resources :users
  end

  resources :tasks
  root 'tasks#index'

  # ユーザーのルーティング
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
