class Program < ApplicationRecord
	has_many :workout_programs, dependent: :destroy
	has_many :workouts, through: :workout_programs, dependent: :destroy
	has_one :user_program, dependent: :destroy
end
