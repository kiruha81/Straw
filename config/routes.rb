Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords"
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"

    resources :customers, except: [:new, :create, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdrawal" => "customers#withdrawal"

    resources :shops, except: [:destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy, :index]
      resources :reviews, only: [:create, :destroy]
    end
    resources :maps

  end

  namespace :admin do
    root to: "homes#top"
    resources :customers, except: [:new, :create, :destroy]
    resources :shops, except: [:new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update]
  end

end
