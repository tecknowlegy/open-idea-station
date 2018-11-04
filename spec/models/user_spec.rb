require "rails_helper"

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user)
  end
  # Association tests
  it { should have_many(:ideas) }
  it { should have_many(:comments) }
  it { should have_many(:notifications) }

  # Validation tests
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
