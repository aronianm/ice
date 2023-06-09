class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	before_action :authenticate_user!
    before_action :set_roles

    after_action :update_user_online, if: :user_signed_in?
    before_action :global_variables

    def global_variables
        if current_user
            @requests = current_user.trainor_requests.where(:accepted => nil).size
            @message_requests = RequestChat.where(:trainor_id => current_user.id, accepted: false).size
        end
    end
   	protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :avatar, :fname, :lname, :weight, :level, :goal)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :current_password)}
    end

    def set_roles
        begin 
            @roles = current_user.roles.map(&:name)
        rescue
            @roles = []
        end
    end

    def update_user_online
      current_user.try :touch
      @current_user = current_user
    end
    
end
