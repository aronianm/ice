class UsersTrainorController < ApplicationController
	before_action :set_user_trainor_connection, except: [:index]
	def index
		@requested_users = UserTrainor.includes(:trainor, :user).where(:trainor_id => current_user, accepted: nil)
		@requested_messages =  RequestChat.where(:trainor_id => current_user.id, accepted: false)
	end

	def show
		if current_user.id == @trainor.id
			binding.pry
		else
		end
	end


	private
	def set_user_trainor_connection
		@user_trainor = UserTrainor.find(params[:id])
		@trainor = @user_trainor.trainor
		@user = @user_trainor.user
	end

end