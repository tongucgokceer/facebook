class UsersController < ApplicationController

    before_action :redirect_to_root

    def index
        @users=User.where('id IN (SELECT DISTINCT(user_id) FROM profiles)').where.not(id: current_user.id)
    end

    def show
        @profile=User.find(params[:id]).profile
        @posts=User.find(params[:id]).posts
        @comment=Comment.new
        @post=Post.new
    end

    def friends
        #@user=User.find(params[:user_id])
        @user=current_user
        @friends=@user.friends
    end
    
    private

    def redirect_to_root
        redirect_to new_profile_path if current_user.profile == nil
    end
end