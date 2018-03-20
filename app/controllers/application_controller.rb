class ApplicationController < ActionController::Base
    def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.try('admin ?')
  end
end
