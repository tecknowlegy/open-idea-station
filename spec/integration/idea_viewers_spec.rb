require "rails_helper"

RSpec.describe IdeaViewersController, type: :request do
  let!(:user) { create :user }
  let!(:idea) { create :idea, user: user }
  let!(:viewer) { create :viewer, idea: idea }

  before do
    stub_current_user(user)
  end

  describe "GET #index" do
    it "returns all views for an idea" do
      get_xhr(idea_viewers_path({ idea_id: idea.id }))
      viewers = idea.viewers

      expect(response).to be_success
      expect(viewers.size).to be 1
    end
  end

  describe "GET #show" do
    it "return a specific viewer for an idea" do
      get_xhr(idea_viewer_path({ idea_id: idea.id, id: viewer.id }))

      expect(response).to be_success
    end
  end
end
