class Viewer < ApplicationRecord
  include UniqueIdentifier

  belongs_to :idea

  def uid_prefix
    "viw"
  end
end
