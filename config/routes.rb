Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    resources :users
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      member do
        get :following, to: "followings#index"
        get :followers, to: "followeds#index"
      end
    end
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(new create edit update)
    resources :microposts, only: %i(create destroy)
    resources :password_resets, except: %i(show destroy index)
    resources :microposts, :relationships, only: %i(create destroy)
  end
end
