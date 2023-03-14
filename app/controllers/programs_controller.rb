class ProgramsController < ApplicationController
	def index
		@programs = Program.where(:created_by => current_user.id)
	end

	def edit 
		@program = Program.find_by(id: params[:id], :created_by => current_user.id)
		@workouts =  @program.workouts
	end

	def create
		@program = Program.new(program_params)
		@program.created_by = current_user.id
		@program.updated_by = current_user.id
		@program.save

		redirect_to @program
		
	end

	def destroy
		@program = Program.find_by(id: params[:id], :created_by => current_user.id)
		@program.delete
		redirect_to user_programs_path(current_user)
	end

	def first
		@program = Program.new

		render layout: false
	end

	def new
		@program = Program.new
	end

	def show
		@program = Program.find_by(id: params[:id], :created_by => current_user.id)
	end



	private
	def program_params
		params['program'].permit(:name)
	end
end
