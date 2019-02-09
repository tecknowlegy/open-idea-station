require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  # Association tests
  it { should have_many(:ideas) }
  it { should have_many(:comments) }
  it { should have_many(:notifications) }

  # Validation tests
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  describe ".find_or_create_from_ominauth" do
    it "creates an account for a google user" do
      github_user = User.find_or_create_from_omniauth(stub_github_auth)

      expect(github_user.provider).to eql "github"
      expect(github_user.uid).to eql "123456"
      expect(github_user.username).to eql "johndoe"
    end

    it "creates an account for a google user" do
      google_user = User.find_or_create_from_omniauth(stub_google_auth)

      expect(google_user.provider).to eql "google_oauth2"
      expect(google_user.uid).to eql "123456"
      expect(google_user.username).to eql "johndoe"
    end

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
  end
end
