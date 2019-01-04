require "rails_helper"

describe IdeaPresenter do
  let!(:user) { create :user }
  let!(:idea) { create :idea, user: user }
  let(:idea_presenter) { described_class.new(idea, ActionView::Helpers::DateHelper) }

  describe ".author_name" do
    it "returns the author name" do
      expect(idea_presenter.author_name).to eql user.username.titleize
    end
  end

  describe ".name" do
    it "returns the name of the model" do
      expect(idea_presenter.name).to eql idea.name
    end
  end

  describe ".view_count" do
    it "returns the view count on the idea" do
      expect(idea_presenter.view_count).to eql idea.viewers.size
    end
  end

  describe ".comment_count" do
    it "returns the count of the comments on the idea" do
      expect(idea_presenter.comment_count).to eql idea.comments.size
    end
  end

  describe ".publication_status" do
    context "when idea is published" do
      it "returns the period it was published" do
        idea.update(published_at: Time.now)
        expect(idea_presenter.publication_status)
          .to eql "Published #{ActionView::Helpers::DateHelper.time_ago_in_words(idea.published_at)} ago"
      end
    end

    context "when idea is not published" do
      it "returns the period it was published" do
        expect(idea_presenter.publication_status).to eql "Draft"
      end
    end
  end

  describe ".tags" do
    context "when there are tags on an idea" do
      it "returns the category tags on the idea" do
        idea.categories.create({ name: "RSpec", description: "Tesing stuff" })
        expect(idea_presenter.tags).to eql "RSpec"
      end
    end

    context "when there are no tags on an idea" do
      it "returns a message" do
        expect(idea_presenter.tags).to eql "No tags have been added"
      end
    end
  end
end
