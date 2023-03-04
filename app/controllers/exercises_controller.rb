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


	private
	def exercise_params
		params[:exercise].permit(:name, :sets, :reps, :duration, :target_muscle_id, :target_sub_muscle_id)
	end

end