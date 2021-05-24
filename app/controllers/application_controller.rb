class ApplicationController < ActionController::Base
    before_action :authenticate_user!


    protected

    def after_sign_in_path_for(user)
        if user.profile == nil
            new_profile_path
        else
            posts_path 
        end
    end


end
