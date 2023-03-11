class HomeController < ApplicationController

	def index
		if current_user.has_role?(:user)
			if current_user.has_trainor?
			else
				@trainors = User.personal_trainors
			end
		end
	end
end
