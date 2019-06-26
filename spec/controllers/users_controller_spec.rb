require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:current_session) { Session.first }
  let(:user) { create :user }
  let!(:all_users) { User.all }
  let(:user_params) do
    {
      user: {
        username: "johndoe",
        email: "john_doe@gmail.com",
        password: "12345678",
        password_confirmation: "12345678",
      },
    }
  end

  before do
    stub_current_user(user)
  end

  describe "GET #index" do
    it "redirects to new user path" do
      get_xhr(:index)

      expect(response).to be_redirect
      expect(response).to redirect_to new_user_path
    end
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
      it "creates a new user and send email confirmation" do
        expect { post_xhr(:create, user_params) }.to change { all_users.size }.by(1)
        expect(response).to be_success
        expect(flash[:notice]).to eql "We have sent you an email, please use the link to complete your registration"
        expect(response).to redirect_to new_user_path
      end
    end

    context "when invalid parameters are passed" do
      it "does not create the user" do
        invalid_params = {
          user: {
            username: "john.doe",
            email: "john_doe@gmail.com",
            password: "12345678",
            password_confirmation: "12345678",
          },
        }

        expect { post_xhr(:create, invalid_params) }.to change { all_users.size }.by(0)
        expect(response).to redirect_to new_user_path
        expect(flash[:error]).to eql "Username is invalid"
      end
    end
  end
end
