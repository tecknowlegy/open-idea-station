require "rails_helper"

describe Acorn::AuthorizeUserService do
  let!(:user1) { create :user }
  let(:user_credentials) { { username: user1.username, password: user1.password } }
  subject(:authenticate_status) { Acorn::AuthenticateUserService.call(user_credentials) }
  let(:token) { authenticate_status.result }
  # Instantiate invalid request subject
  subject(:authorized_userA) { described_class.new({}).call.result }
  # Instantiate valid request subject
  subject(:authorized_userB) { described_class.new(token).call.result }

  context "when the user has a valid request token" do
    it "returns successfully authorizes the user" do
      expect(authorized_userB).to be true
    end
  end

  context "when the user has no valid request token" do
    it "returns the invalid user object" do
      token_error = described_class.new({}).call.errors[:token].first
      expect(authorized_userA).to eq(nil)
      expect(token_error).to eql "No Token was provided"
    end
  end
end
