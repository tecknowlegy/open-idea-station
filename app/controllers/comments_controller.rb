class CommentsController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.create(comment_params)
    redirect_to @idea
  end

  private
    def comment_params
      params[:comment][:user_id] = current_user[:id]
      params.require(:comment).permit(:user_id, :body)
    end
end
