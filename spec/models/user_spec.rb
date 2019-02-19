require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:user_session) { create :session, user: user }
  let!(:current_session) { Session.first }

  # Association tests
  it { should have_many(:ideas) }
  it { should have_many(:comments) }
  it { should have_many(:notifications) }

  # Validation tests
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  describe "#bio" do
    context "when bio exist" do
      it "retrieves the users bio" do
        user.update({ bio: "This is a test bio" })
        bio = user.bio

        expect(bio).to eql "This is a test bio"
      end
    end

    context "when bio does not exist" do
      it "sets a default message" do
        bio = user.bio

        expect(bio).to eql "Bio is yet to be updated"
      end
    end
  end

  describe "#provider" do
    context "when provider exist" do
      it "retrieves the user account provider" do
        user.update({ provider: "github" })
        provider = user.provider

        expect(provider).to eql "github"
      end
    end

    context "when provider does not exist" do
      it "sets a default provider" do
        provider = user.provider

        expect(provider).to eql "open-idea-station"
      end
    end
  end
end
