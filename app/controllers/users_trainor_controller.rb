class UsersTrainorController < ApplicationController
	before_action :set_user_trainor_connection, except: [:index]
	def index
		if params[:requests]
			@requested_users = UserTrainor.includes(:trainor, :user).where(:trainor_id => current_user, accepted: nil)
		else
			@requested_users = UserTrainor.includes(:trainor, :user).where(:trainor_id => current_user, accepted: true)
		end
	end

	def show
	end


	private
	def set_user_trainor_connection
		@user_trainor = UserTrainor.find(params[:id])
		@trainor = @user_trainor.trainor
		@program = @user_trainor.program
		@user = @user_trainor.user
	end

end