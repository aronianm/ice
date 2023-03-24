class Trainor::WorkoutsController < Trainor::TrainorApplicationController 

	def new
		@workout = Workout.new
	end

	def create
		@workout = Workout.new(workout_params)
		@workout.created_by = current_user.id
		@workout.updated_by = current_user.id
		@program = Program.find(params[:id])
		if @workout.save
			WorkoutProgram.create(:workout_id => @workout.id, :program_id => @program.id)
			program_exercises[:exercises].each do |workout, data|
				ExerciseWorkout.create(exercise_id: data[:exercise_id], workout_id: @workout.id)
				data[:exercise_sets].each do |i, exercise|
					exercise_user = ExerciseUser.new(exercise)
					exercise_user.program_id = params[:id]
					exercise_user.exercise_id = data[:exercise_id],
					exercise_user.user_id = @program.user_program.user_id
					exercise_user.save
				end
			end
		end
	end

	def show
		@program = Program.find(params[:id])
		@workout = Workout.find(params[:workout_id])
		@exercises = @workout.exercises
		render :template => "trainor/workouts/show", layout: false
	end



	private
	def program_exercises
		params[:program_workouts].permit!
	end

	def workout_params
		params[:program_workouts].permit(:name)
	end
end