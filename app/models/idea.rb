class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :viewers, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10 }

  # default values are part of domain logic and should be kept together with
  # the rest of the domain logic of the application, in the model layer.
  attribute :is_archived, :boolean, default: false
  after_destroy :broadcast_delete
  after_save :save_categories

  attr_writer :all_categories

  def impression
    read_attribute(:impression) || 0
  end

  def increment_impression
    with_lock do
      increment!(:impression)
    end
  end

  concerning :Categories do
    included do
      has_many :idea_categories, dependent: :destroy
      has_many :categories, through: :idea_categories
    end

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
end
