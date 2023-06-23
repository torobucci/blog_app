class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:text))
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_url(@post.author, @post), notice: 'Comment created successfully.'
    else
      flash.now[:error] = 'Error: Comment could not be saved'
      redirect_to user_post_url(@post.author, @post)
    end
  end
end
