require "rails_helper"

describe BasePresenter do
  let!(:user) { create :user }
  let(:base)  { described_class.new(user, "UserView") }

  describe ".current_view" do
    it "returns the current view" do
      expect(base.current_view).to eql "UserView"
    end
  end

  describe ".mark_down" do
    it "returns a markdown text" do
      expect(base.markdown("SomeText")).to eql "<p>SomeText</p>\n"
    end
  end
end
