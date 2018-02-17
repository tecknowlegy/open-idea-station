class Idea < ApplicationRecord
  include CableBroadcast
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :view_histories, dependent: :destroy
  has_many :idea_categories
  has_many :categories, through: :idea_categories

  validates :name, presence: true, length: {minimum: 3}, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: {minimum: 10}

  after_destroy :broadcast_delete

  def broadcast_delete
    send_broadcast({ status: 'delete', id: id, name: name })
  end
  private
end
