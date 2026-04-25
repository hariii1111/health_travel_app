Rails.application.routes.draw do
  devise_for :users, skip: [:passwords]

  get "dashboard", to: "users#dashboard"
  get "mypage", to: "users#mypage"

  resources :exercises, only: [:index, :new, :create, :edit, :update, :destroy]

  # ログイン後のトップページ（ホーム）
  authenticated :user do
    root "users#home", as: :authenticated_root
  end

  # ログアウト後（ログイン前）のトップページ
  unauthenticated do
    root "home#index"
  end

  devise_scope :user do
    get "logout_complete", to: "home#logout"
  end
end
