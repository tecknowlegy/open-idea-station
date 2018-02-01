class Idea < ApplicationRecord
  has_many :view_histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :idea_categories
  has_many :categories, through: :idea_categories
  validates :name, presence: true, length: {minimum: 10}
  validates :description, presence: true, length: {minimum: 20}
end
