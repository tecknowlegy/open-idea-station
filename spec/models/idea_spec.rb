require "rails_helper"

RSpec.describe Idea, type: :model do
  before(:all) do
    @idea = create(:idea)
  end
  # Association test
  it { should have_many(:categories) }
  it { should have_many(:viewers) }
  it { should have_many(:comments) }
  it { should have_many(:idea_categories) }
  it { should belong_to(:user) }

  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it "has a default value of false for `is_archived`" do
    expect(@idea.is_archived).to be false
  end

  it "returns the specified value for `is_archived` when provided" do
    archived_idea = create(:idea, is_archived: true)
    expect(archived_idea.is_archived).to be true
  end
end
