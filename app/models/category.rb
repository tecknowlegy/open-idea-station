class Category < ApplicationRecord
  has_many :idea_categories, foreign_key: :category_id
  has_many :ideas, through: :idea_categories
  validates_uniqueness_of :name
end
