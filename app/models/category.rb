class Category < ApplicationRecord
  has_many :idea_categories
  has_many :ideas, through: :idea_categories
  validates_uniqueness_of :name
end
