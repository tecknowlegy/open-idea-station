require "rails_helper"

describe Acorn::AuthenticateUserService do
  let!(:user1) { create :user }
  let(:user_credentials) { { username: user1.username, password: user1.password } }
  subject(:authenticate_status) { described_class.call(user_credentials) }

  describe ".call" do
    context "when the user credential exists or is correct" do
      it "successfully authenticates the user" do
        expect(authenticate_status).to be_success
      end
    end

    context "when the correct email is provided as username" do
      let(:user_credentials) { { username: user1.email, password: user1.password } }

      it "successfully authenticates the user" do
        expect(authenticate_status).to be_success
      end
    end

    context "when the user credential does not exist or incorrect" do
      let(:user_credentials) { { username: user1.username, password: "1234567" } }

      it "it fails to authenticate the user" do
        expect(authenticate_status).to be_failure
        expect(authenticate_status.errors[:user_authentication][0]).to eql "Invalid credentials"
      end
    end

    context "when user is successfully authenticated" do
      let(:user_credentials) { { username: user1.email, password: user1.password } }

      it "generates a jwt token for the user" do
        expect(authenticate_status.result.blank?).to eql false
      end
    end

    context "when user is not successfully authenticated" do
      let(:user_credentials) { { username: user1.email, password: "123457" } }

      it "does generate a jwt token for the user" do
        expect(authenticate_status.result.blank?).to eql true
      end
    end
  end
end
