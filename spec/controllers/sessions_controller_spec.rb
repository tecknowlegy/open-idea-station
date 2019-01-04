require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create :user }
  let!(:user2) { create :user }
  let(:user_session) { create :session, user: user }
  let(:current_session) { Session.first }
  let(:session_params) do
    {
      session: {
        username: user.username,
        password: user.password,
        user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:64.0) Gecko/20100101 Firefox/64.0",
        ip_address: "127.0.0.1",
        location: nil,
        device_platform: :browser,
      },
    }
  end

  before do
    stub_current_user(user)
  end

  describe "POST #create" do
    context "when credentials are valid" do
      it "successfully creates a user session" do
        post_xhr(:create, session_params)
        current_user_session = User.find_user_by_session(Session.first.token)

        expect(response).to be_success
        expect(Session.all.size).to be 1
        expect(user.username).to eql current_user_session.username
        expect(flash[:success]).to eq "You are now signed in"
      end
    end

    context "when credentials are invalid" do
      invalid_credential = {
        session: {
          username: "user.username",
          password: "password",
        },
      }

      it "does not create a user session" do
        post_xhr(:create, invalid_credential)

        expect(response).to redirect_to(new_user_path)
        expect(Session.all.size).to be 0
        expect(flash[:error]).not_to be nil
      end
    end
  end

  describe "GET #create_with_omniauth" do
    before do
      stub_create_with_omniauth(user2)
    end

    it "successfully creates a session for the user" do
      get_xhr(:create_with_omniauth, { provider: "github" })
      current_user_session = User.find_user_by_session(Session.first.token)

      expect(Session.all.size).to be 1
      expect(user2.username).to eql current_user_session.username
      expect(flash[:success]).to eq "You are now signed in"
    end
  end

  describe "GET #index" do
    before do
      stub_current_session(user_session)
    end

    context "when a single session exists for a user" do
      it "returns assigned session info" do
        get_xhr(:index)

        expect(response).to be_success

        expect(assigns(:active_sessions)).to be_kind_of(Array)
        expect(assigns(:active_sessions)).to eql []

        expect(assigns(:inactive_sessions)).to be_kind_of(ActiveRecord::AssociationRelation)
        expect(assigns(:inactive_sessions).to_a).to eql []

        expect(assigns(:current_session)).to be_kind_of(Session)
        expect(assigns(:current_session).token).to equal user_session.token
      end
    end

    context "when more than one session exists for a user" do
      it "returns all assigned session info" do
        post_xhr(:create, session_params) # create an extra session
        get_xhr(:index)

        expect(response).to be_success

        expect(assigns(:active_sessions).size).to eql 1

        expect(assigns(:inactive_sessions).to_a).to eql []

        expect(assigns(:active_sessions).first).not_to eql user_session
        expect(assigns(:current_session)).to eql user_session

        # show that the session belongs to the same user
        expect(assigns(:current_session).user).to eql assigns(:active_sessions).first.user
      end

      context "when there's a revoked session" do
        it "returns inactive sessions" do
          post_xhr(:create, session_params) # create an extra session
          get_xhr(:index) # initialize instance variables
          assigns(:active_sessions).first.revoke! # revoke created session
          get_xhr(:index) # re-initializes instance variables

          expect(response).to be_success

          expect(assigns(:active_sessions).size).to eql 0

          expect(assigns(:inactive_sessions).to_a.size).to eql 1

          expect(assigns(:inactive_sessions).first).not_to eql user_session
          expect(assigns(:current_session)).to eql user_session
        end
      end
    end
  end

  describe "Revoking and Deleting User Sessions" do
    before do
      post_xhr(:create, session_params)
    end

    describe "DELETE #revoke" do
      it "successfully revokes a user session by id" do
        delete_xhr(:revoke, { id: current_session.id })
        current_session.reload

        expect(response).to be_success
        expect(flash[:notice]).to eql "Session successfully revoked"
        expect(current_session.active).to be false

        # it does not remove the token from cookie/session
        expect(cookies[:user_id]).not_to be nil
        expect(session[:token]).not_to be nil
      end

      it "successfully revokes a user session by token" do
        delete_xhr(:revoke, { id: "", token: current_session.token })
        current_session.reload

        expect(response).to be_success
        expect(flash[:notice]).to eql "Session successfully revoked"
        expect(current_session.active).to be false

        # it does not remove the token from cookie/session
        expect(cookies[:user_id]).not_to be nil
        expect(session[:token]).not_to be nil
      end
    end

    describe "DELETE #revoke_all" do
      context "when the only session is the current session" do
        it "does not revoke the current session" do
          delete_xhr(:revoke_all)
          current_session.reload

          expect(response).to be_success
          expect(flash[:notice]).to eql "All sessions successfully revoked"
          expect(current_session.active).to be true

          # it does not remove the token from cookie/session
          expect(cookies[:user_id]).not_to be nil
          expect(session[:token]).not_to be nil
        end
      end

      context "when user has more than one session" do
        it "successfully revokes all sessions except the current session" do
          user_session # create another session for user
          delete_xhr(:revoke_all)
          user_sessions = user.sessions
          user_sessions.reload

          expect(user_sessions.first.active).to be true
          expect(user_sessions.last.active).to be false
        end
      end
    end

    describe "DELETE #destroy" do
      it "successfully revokes a user session and removes the token" do
        delete_xhr(:destroy, { id: current_session.id })
        current_session.reload

        expect(response).to be_success
        expect(flash[:notice]).to eql "You are now logged out"
        expect(current_session.active).to be false
        expect(cookies[:user_id]).to be nil
        expect(session[:token]).to be nil
      end
    end
  end
end
