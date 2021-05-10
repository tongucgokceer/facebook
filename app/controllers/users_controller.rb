class UsersController < ApplicationController
    def index
    end

    def show
        @profile=current_user.profile
    end
end
