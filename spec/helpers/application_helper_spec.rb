require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  let!(:idea) { create :idea }
  let!(:presented_idea) {
    present(idea) do
      idea
    end
  }
  describe "#present" do
    context "when idea presenter" do
      it "presents a model object" do
        expect(presented_idea).to be idea
      end
    end
  end
end
