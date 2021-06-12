class CommentsController < ApplicationController



    def create
        @comment=Comment.new
        
        @comment.body=params[:comment][:body]
        @comment.user_id=current_user.id
        @comment.post_id=params[:comment][:post_id]
        #@comment.save!
        #UserMailer.with(user: current_user).welcome_email.deliver_now

        redirect_to posts_path, :notice => "Comment created !!!" if @comment.save
    end

    def destroy
        @comment=Comment.find(params[:id])
        @comment.destroy
        redirect_to posts_path, :notice => "Comment deleted !!!"
    end

end