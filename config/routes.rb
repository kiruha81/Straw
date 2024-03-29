Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords"
  }
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"

    resources :customers, except: [:new, :index, :create, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    get "/customers/:current_customer_id/unsubscribe" => "customers#unsubscribe", as: "customers/unsubscribe"
    patch "/customers/:current_customer_id/withdrawal" => "customers#withdrawal", as: "customers/withdrawal"
    get "/favorites" => "customers#favorites", as: "favorites"

    resources :shops, except: [:destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy, :index]
      resources :reviews, only: [:create, :destroy, :index]
      collection do
        get "search"
      end
    end
    get "/ranking/" => "shops#ranking", as: "ranking"
  end

  namespace :admin do
    root to: "homes#top"
    resources :customers, except: [:new, :create, :destroy]
    resources :shops, except: [:new, :create, :destroy] do
      resources :comments, only: [:destroy]
      resource :favorites, only: [:index]
      resources :reviews, only: [:destroy, :index]
      collection do
        get "search"
      end
    end
    resources :genres, only: [:index, :create, :edit, :update]
    get "/ranking/" => "shops#ranking", as: "ranking"
    get "/reviews/all/" => "reviews#all", as: "reviews_all"
  end

end
