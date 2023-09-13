Rails.application.routes.draw do
  # 管理者側のdeviseのルーティング
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー側のdeviseのルーティング
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者側のルーティング
  namespace :admin do
    get 'homes/top'
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:destroy]
  end

  # ユーザー側のルーティング設定
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :edit, :update, :show] do
      # フォローのルーティング
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      # いいね一覧のルーティング、id含む
      member do
        get :likes
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
