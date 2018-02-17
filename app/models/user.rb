class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  has_many :ideas, dependent: :destroy
  has_many :comments
  has_many :notifications, foreign_key: :recipient_id
end
