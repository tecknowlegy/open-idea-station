class IdeaCategory < ApplicationRecord
  belongs_to :idea, foreign_key: :idea_id
  belongs_to :category, foreign_key: :category_id
end
