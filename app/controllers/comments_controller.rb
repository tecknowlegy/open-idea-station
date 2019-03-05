class CommentsController < ApplicationController
  before_action :set_idea, only: %i[create]
  def create
    return if comment_params[:body].blank?

    @comment = @idea.comments.create!(comment_params)
    redirect_to @idea
  end

  private

  def set_idea
    @idea = Idea.find_by_slug_name(params[:idea_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
