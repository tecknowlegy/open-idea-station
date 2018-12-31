# This is an attempt to use `uid` as a PK compared to auto-incrementing integers
# see this medium post below:
# https://tomharrisonjr.com/uuid-or-guid-as-primary-keys-be-careful-7b2aa3dcb439
module UniqueIdentifier
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  private

  # TODO: create a uid generation module (Acorn::Bubble.generate())
  # params should include: uid_prefix, size(byte size of generated code), time
  def generate_uid
    return unless respond_to?(:uid=) # so that we dont have issues running migration scripts

    self.uid = Acorn::Bubble.generate(model_prefix, 96, time = Time.now)
  end
end
 