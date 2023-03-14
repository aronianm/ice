class WorkoutsController < ApplicationController
  before_action :set_program, except: [:create, :show, :update]

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
      workout_program = WorkoutProgram.new(program_params)
      workout_program.workout_id = @workout.id
      if workout_program.save!
        @message = "Succesffuly created workout"
      else
        @workout.delete
      end
    end
    render layout: false
  end

  def show 
    @workout_program = WorkoutProgram.find_by(:program_id => params[:program_id], :workout_id => params[:id])
    @workout = @workout_program.workout
    @program = @workout_program.program
    @workout_exercises =  ExerciseWorkout.where(:workout_id => @workout.id)
    @exercises = @workout.exercises
    respond_to do |format|
      format.js{}
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

  def update
    @workout = Workout.find_by(:id => params[:id])
    @workout.update!(workout_params)
  end

  private
  def workout_params
    workout_params = params['workout']
    workout_params.permit(:name, :notes, :day)
  end

  def exercise_params
    params['workouts']['exercises']
  end

  def set_program
    @program = Program.find(params[:program_id])
  end

  def program_params
    params[:program].permit(:program_id)
  end
end
