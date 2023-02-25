class User < ApplicationRecord
  rolify :before_create => :before_add_method

  before_create :add_created_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ## Validations
  has_one_attached :avatar

  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }



  def add_created_role
    self.add_role(:user) if self.roles.blank?
  end

end
