class Category < ApplicationRecord
  include UniqueIdentifier

  has_many :idea_categories, dependent: :destroy
  has_many :ideas, through: :idea_categories
  validates_uniqueness_of :name

  def uid_prefix
    "cat"
  end
end
