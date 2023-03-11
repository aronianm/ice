class ProgramsController < ApplicationController
	def index
		@programs = Program.where(:created_by => current_user.id)
	end

	def edit 
		@program = Program.find_by(id: params[:id], :created_by => current_user.id)
	end

	def create
		@program = Program.new(program_param_values)
		@program.created_by = current_user.id
		@program.updated_by = current_user.id
	end

	def destroy
		@program = Program.find_by(id: params[:id], :created_by => current_user.id)
		@program.delete
		redirect_to user_programs_path(current_user)
	end

	def create_name
	end

	def add_workouts
		@program = Program.new(program_param_values)
		@program.created_by = current_user.id
		@program.updated_by = current_user.id
		if @program.save
			@locations = Muscle.all.group_by(&:location).map{|n, v| [n, v.pluck(:id)]}.to_h
			@exercises = Exercise.where(:created_by => current_user.id)
			@target_muscle_ids = @exercises.map(&:target_muscle_id)
			@target_sub_muscle_ids = @exercises.map(&:target_sub_muscle_id).compact
		else
			raise 
		end
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
		binding.pry
		render :json => Exercise.where(:id => params[:exercises], :created_by => current_user.id).as_json
	end



	private
	def program_params
		params['programs']
	end

	def program_param_values
		program_params.permit(:name)
	end

	def program_params_workouts
		params['program']['workouts']
	end
end
