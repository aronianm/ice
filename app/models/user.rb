class User < ApplicationRecord
  rolify :before_create => :before_add_method

  before_create :add_created_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ## Validations
  has_one_attached :avatar
  has_one :personal_trainor_user

  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }


  scope :personal_trainors, -> {
    where(is_trainor: true)
  }
  def formatted_name
    "#{self.fname} #{self.lname}"
  end

  def pluralized_name
    " #{self.formatted_name}'s "
  end

  def add_created_role
    self.add_role(:user) if self.roles.blank?
  end

  def online?
    updated_at > 2.minutes.ago
  end

  def formatted_location
    return "Unknown" if self.city.nil? || self.state.nil?
    "#{self.city} #{self.state}"
  end

  def has_trainor?
    !personal_trainor_user.nil?
  end

  def is_trainor?
   self.has_role?('personal_trainor')
  end

  def name
    "#{self.fname} #{self.lname}"
  end

  def formatted_ratings
    return "<i>Not rated</i>" if self.rating.nil?
    star_html = """<div><svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'>
                    <path stroke-linecap='round' stroke-linejoin='round' d='M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z'/>
                    </svg>
                    </div>
                """
    returnHtml = ""
    self.rating.floor.times do 
      returnHtml += star_html
    end
    remaing = (self.rating - self.rating.floor).to_f
    percentage = 25 * remaing
    star_html = """<div style='width: #{percentage.to_f}px; overflow: hidden'>
                      <svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'>
                    <path stroke-linecap='round' stroke-linejoin='round' d='M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z'/>
                    </svg>
                    </div>
                """
    returnHtml += star_html
    return returnHtml.html_safe
  end

end
