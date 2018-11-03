class CommentsController < ApplicationController
  def create
    return if comment_params[:body].blank?

    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.create!(comment_params)
    redirect_to @idea
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
