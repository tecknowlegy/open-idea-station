class IdeaViewersController < ApplicationController
  before_action :set_idea, only: %i[index]
  # before_action :ensure_idea_owner, only: %i[show]

  def index
    @idea_viewers = @idea.viewers
  end

  def show
    @idea_viewer = Viewer.find_by(id: params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:idea_id])
  end

  def ensure_idea_owner
    raise StandardError if @idea.user.id != current_user.id
  rescue StandardError
    flash[:warning] = "You are not authorized to perform this action"
    redirect_to @idea
  end
end
