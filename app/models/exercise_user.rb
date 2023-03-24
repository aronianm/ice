class ExerciseUser < ApplicationRecord
	belongs_to :exercise
	belongs_to :program
	belongs_to :user
end
