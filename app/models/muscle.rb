class Muscle < ApplicationRecord



	def self.all_muscles
		@muscles ||= Muscle.all
	end

	def formatted_name
		"#{self.name.titleize()} (#{self.location.titleize})"
	end

end