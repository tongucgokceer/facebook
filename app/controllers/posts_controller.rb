class PostsController < ApplicationController
    before_action :redirect_to_root

    def index
        @users = current_user.friends
        @posts=[]
        @users.each do |user|
            user.posts.each do |post|
                @posts << post
                @comment=Comment.new
                @comment.post_id=post.id
            end
          end
        current_user.posts.each do |post|
            @posts << post
            @comment=Comment.new
            @comment.post_id=post.id
        end
        #@posts=Post.all
        #puts @posts.class
        @post=Post.new
    end

    def new
        @post=Post.new
    end

    def create
        @post=Post.new
        @post.body=params[:post][:body]
        @post.user_id=current_user.id
        @post.save
        redirect_to posts_path, :notice => "Post created !!!" 
    end

    def destroy
        @post=Post.find(params[:id])
        @post.destroy
        redirect_to posts_path, :notice => "Post deleted !!!"
    end

    private

    def redirect_to_root
        redirect_to new_profile_path if current_user.profile == nil
    end

    

end