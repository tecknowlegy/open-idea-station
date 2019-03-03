require "rails_helper"

RSpec.describe IdeasController, type: :controller do
  let!(:user) { create :user }
  let!(:idea) { create :idea, user: user }
  let!(:published_idea) { create :idea, user: user, published_at: Faker::Date.between(2.days.ago, Date.today) }
  let!(:user2) { create :user }
  let!(:idea2) { create :idea, user: user2 }
  let!(:idea_params) do
    {
      idea: {
        name: "john_idea",
        description: "some idea john created for test purpose",
        url: "idea_url",
        is_archived: false,
        all_categories: [],
      },
    }
  end

  before do
    stub_current_user(user)
  end

  describe "GET #new" do
    it "create a new idea instance" do
      get_xhr(:new)

      expect(response).to be_success
      expect(assigns(:idea)).to be_instance_of Idea
    end
  end

  describe "GET #index" do
    it "returns only published ideas" do
      get_xhr(:index)
      all_ideas = Idea.all

      expect(response).to be_success
      expect(assigns(:ideas)).to be_kind_of(ActiveRecord::Relation)
      expect(assigns(:ideas).size).to eql 1
      expect(all_ideas.size).to eql 3
    end
  end

  describe "POST #create" do
    it "creates a new idea" do
      post_xhr(:create, idea_params)

      expect(response).to be_success
      expect(assigns(:idea)).to be_instance_of Idea
      expect(assigns(:idea).id).not_to be nil
      expect(assigns(:idea).name).to eql idea_params[:idea][:name]
      expect(flash[:notice]).to eql "Idea was successfully created"
    end

    it "does not create the idea for invalid parameters" do
      invalid_params = {
        idea: {
          name: "jo",
          description: "some",
          url: "idea_url",
          is_archived: false,
          all_categories: [],
        },
      }
      post_xhr(:create, invalid_params)

      expect(assigns(:idea).id).to be nil
      expect(subject).to render_template(:new)
    end
  end

  describe "Viewers" do
    context "when the viewer is the owner of the idea" do
      it "does not record the view on that idea" do
        get_xhr(:show, { id: idea.slug_name })
        viewers = idea.viewers

        expect(response).to be_success
        expect(viewers.size).to be 0
      end
    end

    context "when the viewer is not the owner of the idea" do
      it "records the view on that idea" do
        get_xhr(:show, { id: idea2.slug_name })
        viewers = idea2.viewers

        expect(response).to be_success
        expect(viewers.size).to be 1
      end
    end
  end

  describe "GET #edit" do
    it "does not allow an unauthorized user to edit an idea" do
      get_xhr(:edit, { id: idea2.slug_name })

      expect(response.code).to eql "302"
      expect(response).to redirect_to(idea_path(idea2.slug_name))
      expect(flash[:warning]).to eql "You are not authorized to perform this action"
    end

    it "allows an authorized user to edit an idea" do
      get_xhr(:edit, { id: idea.slug_name })

      expect(response).to be_success
    end
  end

  describe "PATCH #update" do
    context "when update action is fired with `commit: Publish`" do
      it "updates and publishes the idea" do
        update_params =
          {
            commit: "Publish",
            id: idea.slug_name,
            idea: {
              name: "name changed",
              description: "some idea john created for test purpose",
              url: "idea_url",
              is_archived: false,
              all_categories: [],
            },
          }
        patch_xhr(:update, update_params)
        updated_idea = assigns(:idea).reload

        expect(response).to be_success
        expect(updated_idea.name).to eq "name changed"
        expect(updated_idea.published_at).not_to be nil
      end
    end

    context "when update action is fired without `commit: Publish`" do
      it "updates the idea, without publishing" do
        update_params =
          {
            id: idea.slug_name,
            idea: {
              name: "name changed again",
              description: "some idea john created for test purpose",
              url: "idea_url",
              is_archived: false,
              all_categories: [],
            },
          }
        patch_xhr(:update, update_params)

        updated_idea = assigns(:idea)

        expect(updated_idea.name).to eq "name changed again"
        expect(response).to redirect_to(idea_path(updated_idea))
        expect(updated_idea.published_at).to be nil
      end
    end

    context "when update action is fired on another users idea" do
      it "does not update the idea" do
        update_params =
          {
            id: idea2.slug_name,
            idea: {
              name: "name won't change",
              description: "some idea john created for test purpose",
              url: "idea_url",
              is_archived: false,
              all_categories: [],
            },
          }
        patch_xhr(:update, update_params)

        expect(assigns(:idea).name).not_to eq "name won't change"
        expect(response).to redirect_to(idea_path(idea2.slug_name))
        expect(assigns(:idea).published_at).to be nil
        expect(flash[:warning]).to eql "You are not authorized to perform this action"
      end
    end

    context "when parameters are not valid" do
      it "does not update the idea for invalid parameters" do
        invalid_params =
          {
            id: idea.slug_name,
            idea: {
              name: "jo",
            },
          }
        patch_xhr(:update, invalid_params)

        expect(assigns(:idea).name).not_to be "jo"
        expect(subject).to render_template(:edit)
      end
    end
  end

  describe "PATCH #destroy" do
    it "does not delete another users idea" do
      delete_xhr(:destroy, { id: idea2.slug_name })

      expect(response).to redirect_to(idea_path(idea2.slug_name))
      expect(assigns(:idea).is_archived).to be false
      expect(flash[:warning]).to eql "You are not authorized to perform this action"
    end

    it "successfully deletes the authorized user idea" do
      delete_xhr(:destroy, { id: idea.slug_name })

      expect(response).to redirect_to(ideas_path)
      expect(assigns(:idea).is_archived).to be true
      expect(flash[:notice]).to eql "#{idea.name} was archived"
    end
  end
end
