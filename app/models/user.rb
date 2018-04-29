class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :username, :email

  has_many :ideas, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
end
