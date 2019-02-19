require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:current_session) { Session.first }
  let(:user) { create :user }
  let(:user_params) do
    {
      user: {
        username: "johndoe",
        email: "jphn_doe@gmail.com",
        password: "12345678",
        password_confirmation: "12345678",
      },
    }
  end

  before do
    stub_current_user(user)
  end

  describe "GET #new" do
    it "returns a bare bone instance" do
      get_xhr(:new)

      expect(response).to be_success
      expect(assigns(:user)).to be_instance_of User
    end
  end

  describe "POST #create" do
    context "when valid parameters are passed" do
      it "creates a new user and session" do
        post_xhr(:create, user_params)

        expect(response).to be_success
        expect(current_session).not_to be nil
        expect(current_session.user.username).to eql "johndoe"
        expect(cookies[:user_id]).not_to be nil
        expect(session[:token]).not_to be nil
        expect(response).to redirect_to(ideas_path)
      end
    end

    context "when invalid parameters are passed" do
      it "does not create the user" do
        invalid_params = {
          user: {
            username: "john.doe",
            email: "jphn_doe@gmail.com",
            password: "12345678",
            password_confirmation: "12345678",
          },
        }
        post_xhr(:create, invalid_params)

        expect(current_session).to be nil
        expect(response).to render_template(:new)
        expect(flash[:error]).not_to be nil
      end
    end

    context "when token generation fails" do
      before do
        allow_any_instance_of(SimpleCommand).to receive(:success?).and_return(
          false
        )
      end
      it "redirects the user to home" do
        post_xhr(:create, user_params)

        expect(response).to redirect_to(new_session_path)
        expect(flash[:notice]).to eql "Account was created but we could not create your session at this time. Please login to continue"
      end
    end
  end
end
