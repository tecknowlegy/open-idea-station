class Idea < ApplicationRecord
  has_many :view_histories, dependent: :destroy
  validates :name, presence: true, length: {minimum: 10}
  validates :description, presence: true, length: {minimum: 20}
end
