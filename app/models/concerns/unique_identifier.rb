# This is an attempt to use `uid` as a PK compared to auto-incrementing integers
# see this medium post below:
# https://tomharrisonjr.com/uuid-or-guid-as-primary-keys-be-careful-7b2aa3dcb439
require "securerandom"
module UniqueIdentifier
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  private

  # Generate UID for model objects
  def generate_uid
    return unless respond_to?(:uid=) # so that we dont have issues running migration scripts

    self.uid = "#{uid_prefix}_#{normalized_random}"
  end

  def normalized_random
    SecureRandom.uuid.split("-").join
  end
end
