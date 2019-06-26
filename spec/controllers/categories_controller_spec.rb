require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let!(:user) { create :user }
  let!(:cat) { create :category }
  let!(:cat2) { create :category }

  before do
    stub_current_user(user)
  end

  describe "GET #index" do
    it "retrieves all categories as JSON data" do
      get_xhr(:index)
      cats = assigns(:categories)
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(response.headers["Content-Type"]).to eql "application/json; charset=utf-8"
      expect(result["data"].size).to eql 2

      expect(cats.size).to eql 2
      expect(cats.first.name).to eql cat.name
      expect(cats.second.name).to eql cat2.name
    end
  end

  describe "GET #show" do
    it "does not record the view on that idea" do
      get_xhr(:show, { id: cat.id })

      expect(response).to be_success
    end
  end

  describe "PATCH #update" do
    it "updates and publishes the idea" do
      update_params =
        {
          id: cat.id,
        }
      patch_xhr(:update, update_params)

      expect(response).to be_success
    end
  end
end
