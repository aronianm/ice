#app/models/room.rb
class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }
  after_create_commit {broadcast_append_to "rooms"}

  belongs_to :user
  belongs_to :trainor, class_name: 'User', foreign_key: :trainor_id, primary_key: :id
  has_many :messages



  def talking_to current_user 
    if self.user_id == current_user.id
      return self.trainor
    else
      return self.user
    end
  end
end