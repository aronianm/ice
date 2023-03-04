Rails.application.routes.draw do

  devise_for :users
  resources :workouts, only: [:index] do
    collection do
      get :kanbaord
    end
  end

  resources :users do 
    resources :workouts do
      collection do
        get :workout_table
      end
    end
    resources :exercises
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "workouts#kanboard"
  resources :calendar, only: [:index] do 
    collection do
      get :day
      get :week
    end
  end
end
