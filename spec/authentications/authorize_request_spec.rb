require 'rails_helper'

describe AuthorizeRequest do
  let!(:user1) { create :user }
  let(:user_credentials) { { username: user1.username, password: user1.password } }
  subject(:authenticate_status) { AuthenticateUser.call(user_credentials) }
  let(:headers) { { 'Authorization' => authenticate_status.result } }
  # Instantiate invalid request subject
  subject(:user_objA) { described_class.new({}).call.result }
  # Instantiate valid request subject
  subject(:user_objB) { described_class.new(headers).call.result }

  context 'when the user has a valid request headers' do
    it 'returns the valid user object' do
      expect(user_objB).to eq(user1)
    end
  end
  
  context 'when the user has no valid request headers' do
    it 'returns the invalid user object' do
      token_error = described_class.new({}).call.errors[:token].first
      expect(user_objA).to eq(nil)
      expect(token_error).to eql 'No Token was provided'
    end
  end
end
