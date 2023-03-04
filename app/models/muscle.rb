class Muscle < ApplicationRecord



	def self.all_muscles
		@muscles ||= Muscle.all
	end

end