class ProgramsController < ApplicationController

	def create_name
	end

	def add_workouts
		@locations = Muscle.all.group_by(&:location).map{|n, v| [n, v.pluck(:id)]}.to_h
		@exercises = Exercise.where(:created_by => current_user.id)
		@target_muscle_ids = @exercises.map(&:target_muscle_id)
		@target_sub_muscle_ids = @exercises.map(&:target_sub_muscle_id).compact
	end

	def add_program_workout
		@workout_name = params[:workout_name]
	end

	def add_exercises
		@locations = Muscle.all.group_by(&:location).map{|n, v| [n, v.pluck(:id)]}.to_h
		@exercises = Exercise.where(:created_by => current_user.id)
		@target_muscle_ids = @exercises.map(&:target_muscle_id)
		@target_sub_muscle_ids = @exercises.map(&:target_sub_muscle_id).compact
	end

	def append_exercises
		render :json => Exercise.where(:id => params[:exercises], :created_by => current_user.id).as_json
	end
end
