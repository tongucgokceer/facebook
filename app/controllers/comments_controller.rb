class CommentsController < ApplicationController



    def create
        @comment=Comment.new
        
        @comment.body=params[:comment][:body]
        @comment.user_id=current_user.id
        @comment.post_id=params[:comment][:post_id]
        #@comment.save!
        redirect_to posts_path, :notice => "Comment created !!!" if @comment.save
    end

end
