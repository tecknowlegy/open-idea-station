class Idea < ApplicationRecord
  # attr_accessor :name, :description, :author, :organization, :url
  has_many :view_histories
end
