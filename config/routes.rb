Rails.application.routes.draw do
  get 'like/create'

  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboard#show"
  end

  root to: 'home#show'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]
  #'text_shouts' or :text_shouts is same, pass the content_type to controller
  post :text_shouts, to: 'shouts#create', defaults: { content_type: TextShout }
  post :photo_shouts, to: 'shouts#create', defaults: { content_type: PhotoShout }
  resources :shouts, only: [:show] do
    member do
      post :like, to: 'likes#create'
      delete :unlike, to: 'likes#destroy'
    end
  end

  resources :users, only: [:create, :show] do
    resources :followers, only: [:index]
    member do
      post :follow, to: 'followed_users#create'
      post :unfollow, to: 'followed_users#destroy'
    end
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
