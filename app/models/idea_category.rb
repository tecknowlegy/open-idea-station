class IdeaCategory < ApplicationRecord
  belongs_to :idea
  belongs_to :category
end
