class Acorn::IdeaViewerService
  prepend SimpleCommand

  def initialize(idea:, user: nil, viewed_at: Time.now, viewer_ip: request.remote_ip)
    @idea      = idea
    @user      = user
    @viewed_at = viewed_at
    @viewer_ip = viewer_ip
  end

  def call
    create
  end

  private

  attr_reader :idea, :user, :viewed_at, :viewer_ip

  def create
    idea.increment_impression

    return if user.present? && Viewer.find_by(user_id: user.id, idea_id: idea.id).present?

    Viewer.create!(idea_id: idea.id, user_id: user&.id, viewed_at: viewed_at, viewer_ip: viewer_ip)
  end
end
