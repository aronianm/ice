class PersonalTrainorUser < ApplicationRecord
	has_one :user
	has_one :personal_trainor, class_name: 'User', foreign_key: :personal_trainor_id, primary_key: :id
end