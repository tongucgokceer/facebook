class UsersController < ApplicationController
    def index
        @users=User.where.not(id: current_user.id)
    end

    def show
        @profile=User.find(params[:id]).profile
    end

    def friends
        @user=User.find(params[:user_id])
        @friends=@user.friends
    end
end