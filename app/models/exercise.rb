class Exercise < ApplicationRecord
	has_one :target_muscle, class_name: "Muscle", foreign_key: :id, primary_key: :target_muscle_id
	has_one :sub_target_muscle, class_name: "Muscle", foreign_key: :id, primary_key: :target_sub_muscle_id


	
end