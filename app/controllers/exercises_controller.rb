class ExercisesController < ApplicationController

	def index
		@exercises = Exercise.where(:created_by => current_user.id)
	end

	def new
		@exercise = Exercise.new
	end

	def create
		@exercise = Exercise.new(exercise_params)
		@exercise.created_by = current_user.id
		@exercise.updated_by = current_user.id
		if @exercise.save
		end
		redirect_to user_exercises_path(current_user)
	end

	def form_workout
    	@exercise = Exercise.find(params[:id])
    	render :partial => "form_exercise", :locals => {:exercise => @exercise}
  	end

   	def search
    	@workout = Workout.find(params[:workout_id])
    	@exercise_workout = ExerciseWorkout.new(:workout_id => @workout.id)
    	@exercises = Exercise.where(:created_by => current_user.id)
    	@workout_exercises =  ExerciseWorkout.create(:workout_id => params[:workout_id] )

  	end

  	def add
  		@workout_exercise =  ExerciseWorkout.create(:exercise_id => params[:id], :workout_id => params[:workout_id] )
  		render :partial => 'list_item', locals: {:workout_exercise => @workout_exercise} 
  	end



	private
	def exercise_params
		params[:exercise].permit(:name, :sets, :reps, :duration, :target_muscle_id, :target_sub_muscle_id)
	end

end