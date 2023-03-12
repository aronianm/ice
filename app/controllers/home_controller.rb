class HomeController < ApplicationController

	def index
		if current_user.is_user
			if current_user.has_trainor?
			else
				@no_trainor = true
				@trainors = User.personal_trainors
				@rooms =  Room.where(:user_id => current_user.id).load.map(&:trainor_id)
			end
		end
	end
end
