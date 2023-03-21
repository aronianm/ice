class UserTrainor < ApplicationRecord
	validates :user_id, uniqueness: { scope: :trainor_id, message: "You already sent user a request"}

	has_one :trainor, class_name: 'User', foreign_key: :id, primary_key: :trainor_id
	belongs_to :user



	def pending?
		self.accepted.nil?
	end

	def program
		UserProgram.find_by(:user_id => self.user_id, :trainor_id => self.trainor_id)
	end
end