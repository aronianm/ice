class Trainor::WorkoutsController < Trainor::TrainorApplicationController 

	def new
		@workout = Workout.new
	end

end