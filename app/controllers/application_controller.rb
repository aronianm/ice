class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	before_action :authenticate_user!
    before_action :set_roles

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
end
