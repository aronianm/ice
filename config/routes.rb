Rails.application.routes.draw do
  root "home#index"
  namespace :trainor do 
     resources :home
     resources :programs, only: [:show, :edit, :delete, :index] do 
      member do
        resources :workouts
      end
     end
     resources :users, only: [:show] do
      resources :programs, only: [:new, :create]
    end
  end
  resources :home, only: [:index] do
    collection do 
      get :privacy_policy
    end
  end
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
        get :accept_room_modal
        post :accept_room
      end
    end
    resources :exercises do 
      resources :exercise_users
    end
    member do 
      resources :programs, only: [:index] do
        collection do 
          get :current_program
        end
      end
      post :accept_user, action: :accept
      get :accept_user, action: :pre_accept
      get :profile
    end
    get :request_trainor, action: :request_modal
    post :request_trainor, action: :request_send
    post :request_trainor_chat, action: :request_chat
  end
 
  resources :calendar, only: [:index] do 
    collection do
      get :day
      get :week
    end
  end

  resources :users_trainor
end
