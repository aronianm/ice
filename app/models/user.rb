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


  def formatted_name
    "#{self.fname} #{self.lname}"
  end

  def pluralized_name
    " #{self.formatted_name}'s "
  end

  def add_created_role
    self.add_role(:user) if self.roles.blank?
  end

end
