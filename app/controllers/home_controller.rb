class HomeController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:index, :privacy_policy]
	def index
		if current_user.is_user
			if current_user.has_trainor?
			else
				@no_trainor = true
				@trainors = User.personal_trainors
				@rooms =  Room.where(:user_id => current_user.id).load.map(&:trainor_id)
			end
		end unless current_user.nil?
	end

	def privacy_policy
	end
end
