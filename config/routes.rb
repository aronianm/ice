Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  
  resources :rooms do
    resources :messages
  end
  resources :programs do 
    resources :workouts, only: [:new, :index, :show]
  end
  resources :workouts do
    resources :exercises do
      member do
        get :add
      end
      collection do 
        get :search
      end
    end
  end
  resources :users do 
    resources :rooms, only: [:new] do
      collection do 
        get :trainor_connect
      end
    end
    resources :exercises do 
      resources :exercise_users
    end
    get :request_trainor, action: :request_modal
    post :request_trainor, action: :request_send
    member do 
      post :accept_user, action: :accept
      get :accept_user, action: :pre_accept
    end
  end
 
  resources :calendar, only: [:index] do 
    collection do
      get :day
      get :week
    end
  end

  resources :users_trainor
end
