class IdeaCategory < ApplicationRecord
  include UniqueIdentifier

  belongs_to :idea
  belongs_to :category

  def uid_prefix
    "idec"
  end
end
