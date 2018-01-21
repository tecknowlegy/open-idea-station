class Idea < ApplicationRecord
  has_many :view_histories, dependent: :destroy
end
