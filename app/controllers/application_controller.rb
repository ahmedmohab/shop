class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.try(:admin?)
  end
    
     protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:userfirstname, :userlastname, :usercity, :userphone, :useraddress])
        devise_parameter_sanitizer.permit(:account_update, keys: [:userfirstname, :userlastname, :usercity, :userphone, :useraddress])
    end
end
