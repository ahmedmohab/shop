class ApplicationController < ActionController::Base
    def set_cookies
        if cookies.signed[:uder_id] == nil
            cookies.permanent.signed[:user_id] = rand(10 ** 10)
        end
    end
end
