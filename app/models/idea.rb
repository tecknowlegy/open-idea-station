class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :viewers, dependent: :destroy
  has_many :idea_categories, dependent: :destroy
  has_many :categories, through: :idea_categories

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10 }

  # default values are part of domain logic and should be kept together with
  # the rest of the domain logic of the application, in the model layer.
  attribute :is_archived, :boolean, default: false

  attr_writer :all_categories

  after_save :save_categories
  after_destroy :broadcast_delete

  def all_categories
    categories.uniq.map(&:name).join(", ")
  end

  private

  def save_categories
    @all_categories&.split(",")&.each do |name|
      categories << Category.where(name: name.strip).first_or_create!
    end
  end
end
