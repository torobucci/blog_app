class Api::CommentsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments

    render json: comments
  end

  

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
