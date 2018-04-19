class Idea < ApplicationRecord
  include CableBroadcast

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :viewers, dependent: :destroy
  has_many :idea_categories, foreign_key: :idea_id
  has_many :categories, through: :idea_categories

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10 }

  after_destroy :broadcast_delete
  after_initialize :set_is_archived

  def set_is_archived
    self.is_archived ||= false
  end

  def broadcast_delete
    send_broadcast(status: 'delete', id: id, name: name)
  end

  def all_categories=(names)
    names.split(',').each do |name|
      self.categories << Category.where(name: name.strip).first_or_create!
    end
  end

  def all_categories
    self.categories.map(&:name).join(', ')
  end

end
