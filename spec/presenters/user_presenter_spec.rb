require "rails_helper"

describe UserPresenter do
  let!(:user) { create :user }
  let(:user_presenter) { described_class.new(user, ActionView::Helpers::DateHelper) }

  describe "#provider" do
    it "returns the provider of the user account" do
      user.update(provider: "github")
      expect(user_presenter.provider).to eql "github"
    end

    context "when provider is `google_oauth2`" do
      it "changes the provider name to google" do
        user.update(provider: "google_oauth2")
        expect(user_presenter.provider).to eql "google"
      end
    end
  end

  describe "#username" do
    it "returns the username of the account" do
      user.update(username: "Dinobi")
      expect(user_presenter.username).to eql "Dinobi"
    end
  end

  describe "#picture" do
    it "returns the picture of the account" do
      user.update(picture: "my_profile_picture_url")
      expect(user_presenter.picture).to eql "my_profile_picture_url"
    end
  end

  describe "#email" do
    it "returns the email of the account" do
      user.update(email: "dinobi.kenkwo@gmail.com")
      expect(user_presenter.email).to eql "dinobi.kenkwo@gmail.com"
    end
  end
end
