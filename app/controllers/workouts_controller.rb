class WorkoutsController < ApplicationController
  def kanboard
    @workouts_to_do = ['Pushups', 'Jumping Jacks']
  end


  def index
    @workouts = Workout.where(:created_by => current_user.id)
  end

  def new
    @workout = Workout.new
    @exercises = Exercise.where(:created_by => [13, current_user.id])
    respond_to do |format|
      format.js
      format.html{
        render  template: 'workouts/create/page' 
    
      }
    end
  end

  def workout_table
    @workouts = Workout.where(:created_by => current_user.id)
    respond_to do |format|
      format.js{
        render "workouts/workout_table", layout: false
      }
    end
  end
end
