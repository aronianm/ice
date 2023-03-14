class Program < ApplicationRecord
	has_many :workout_programs
	has_many :workouts, through: :workout_programs
end
