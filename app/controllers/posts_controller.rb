class PostsController < ApplicationController
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

    def create
        @post=Post.new
        @post.body=params[:post][:body]
        @post.user_id=current_user.id
        @post.save
        redirect_to posts_path, :notice => "Post created !!!" 
    end

end


