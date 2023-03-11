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
    resources :programs do
      collection do 
        get :create_name
        get :add_workouts
        get :add_program_workout
        get :add_exercises
        get 'add_workouts/:location', action: :add_exercise_location, as: :add_exercise_location
        get :append_exercises
      end
    end
    resources :exercises do
      member do 
        get :form_workout
      end
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :calendar, only: [:index] do 
    collection do
      get :day
      get :week
    end
  end
end
