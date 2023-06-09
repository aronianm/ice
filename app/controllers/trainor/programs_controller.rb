class Trainor::ProgramsController < Trainor::TrainorApplicationController 

	before_action :check_for_trainor
	before_action :set_program,  only: [:show]

	def show
		@workouts = @program.workouts
	end

	def new
		@user = User.find(params[:user_id])
		@program = Program.new(:created_by => current_user.id, ready_tag: false)
	end

	def create
		@program = Program.new(program_params)
		@program.created_by = current_user.id
		@program.ready_tag = false
		if @program.save
			UserProgram.create(:user_id => params[:user_id], trainor_id: current_user.id, :program_id => @program.id)
		end
		redirect_to trainor_program_path(@program)
	end


	private
	def check_for_trainor
		if !current_user.is_trainor
			redirect_to root_path
		end
	end

	def program_params
		params[:program].permit(:name)
	end

	def set_program
		begin
			@program = Program.find(params[:id])
		rescue
			redirect_to root_path
		end
	end
end