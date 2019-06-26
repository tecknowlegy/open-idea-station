class CommentsController < ApplicationController
  before_action :set_idea, only: %i[create]
  def create
    return if comment_params[:body].blank?

    @comment = @idea.comments.create!(comment_params)
    redirect_to @idea
  end

  private

  def set_idea
    id = Slug[params[:idea_id]]
    @idea = id ? Idea.find_by!(id: id) : Idea.find_by!(slug_name: params[:idea_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to ideas_path
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
