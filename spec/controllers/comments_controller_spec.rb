require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create :user }
  let!(:idea) { create :idea }
  let!(:comment_params) do
    {
      idea_id: idea.slug_name,
      comment: {
        user_id: user.id,
        body: "some comments I dropped on your idea",
      },
    }
  end

  before do
    stub_current_user(user)
  end

  describe "POST #create" do
    context "when complete parameters are passed" do
      it "creates a new comment on an idea" do
        post_xhr(:create, comment_params)

        expect(response).to be_success
        expect(assigns(:comment)).to be_instance_of Comment
        expect(assigns(:comment).body).to eql "some comments I dropped on your idea"
        expect(assigns(:comment).idea).to eql idea
      end

      it "redirects to the idea page after creation" do
        post_xhr(:create, comment_params)

        expect(response).to redirect_to(idea_path(idea.slug_name))
      end
    end

    context "when complete parameters are not passed" do
      it "creates a new comment on an idea" do
        missing_params = {
          idea_id: idea.slug_name,
          comment: {
            user_id: user.id,
          },
        }
        post_xhr(:create, missing_params)

        expect(assigns(:comment)).to be nil
      end
    end
  end
end
