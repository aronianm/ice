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

  def create
    @workout = Workout.new(workout_params)
    @workout.created_by = current_user.id
    @workout.updated_by = current_user.id
    if @workout.save
      exercise_params.each do |i, exercise|
        exercise_workout = ExerciseWorkout.new(exercise.permit(:exercise_id))
        exercise_workout.workout_id = @workout.id
        exercise_workout.save
      end
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

  private
  def workout_params
    workout_params = params['workouts']
    workout_params.permit(:name, :notes)
  end

  def exercise_params
    params['workouts']['exercises']
  end
end
