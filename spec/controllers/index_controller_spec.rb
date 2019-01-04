require "rails_helper"

RSpec.describe IndexController, type: :controller do
  let!(:user) { create :user }

  before do
    stub_current_user(user)
  end

  describe "GET #index" do
    it "is open idea station" do
      get_xhr(:index)

      expect(response).to be_success
      expect(assigns(:base_app)).to eql "Acorn"
    end
  end
end
