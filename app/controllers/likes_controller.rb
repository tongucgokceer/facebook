class LikesController < ApplicationController
    
    
    before_action :find_post_and_comment
    before_action :find_like, only: [:destroy]


  def create
    if already_liked?
        redirect_to posts_path, :notice => "You can't like more than once !!!" 
    else
        @post.likes.create(user_id: current_user.id)
        redirect_to posts_path, :notice => "Post liked :))))))))))))))))))" 
    end
  end

  def destroy
    if !(already_liked?)
      redirect_to posts_path, :notice => "Cannot unlike !!!" 
    else
      @like.destroy
      redirect_to posts_path #redirects harm the user experience ! it shall be fixed ...
    end
  end


  private
  def find_post_and_comment
    #@post can be either post or comment
    if params[:post_id]
        @post = Post.find(params[:post_id])
    else
        @post=Comment.find(params[:comment_id])
    end
  end

  def already_liked?

    if params[:post_id]
        Like.where(user_id: current_user.id, likeable_id:
        params[:post_id]).exists?
    else
        Like.where(user_id: current_user.id, likeable_id:
        params[:comment_id]).exists?
    end

  end

  def find_like
    if params[:post_id]
        @post=Post.find(params[:post_id])
    else
        @post=Comment.find(params[:comment_id])
    end
    @like=@post.likes.where(user_id: current_user.id).first
 end

end




