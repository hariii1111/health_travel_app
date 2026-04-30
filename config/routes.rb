Rails.application.routes.draw do
  devise_for :users, skip: [:passwords]

  # Admin
  namespace :admin do
    resources :tags
  end

  # User pages
  get "dashboard", to: "users#dashboard"
  get "mypage", to: "users#mypage"

  resources :exercises, only: [:index, :new, :create, :edit, :update, :destroy]

  # ★ root は常に home#index に固定
  root "home#index"

  devise_scope :user do
    get "logout_complete", to: "home#logout"
  end
end
