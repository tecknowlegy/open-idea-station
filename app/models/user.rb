class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  has_many :notifications, foreign_key: :receiver_id
  has_many :comments
  has_many :ideas
end
