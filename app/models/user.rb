class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :username, :email

  has_many :ideas, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  def self.find_or_create_from_omniauth(auth)
    case auth.provider
    when 'google_oauth2'
      find_params = { provider: auth.provider, uid: auth.uid }
    when 'facebook'
      find_params = auth.slice(:provider, :uid)
    end
    
    where(find_params).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.first_name
      user.email = auth.info.email
      user.password = auth.uid
      user.picture = auth.info.image
      user.save!
    end
  end

end
