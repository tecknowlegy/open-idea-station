require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user)
  end
  # Association test
  # ensure User model has a 1:m relationship with the Ideas model
  it { should have_many(:ideas) }
  # Validation tests
  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
