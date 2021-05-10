class ApplicationController < ActionController::Base
    before_action :authenticate_user!


    protected

    def after_sign_in_path_for(user)
        new_profile_path if user.profile == nil
    end


end
