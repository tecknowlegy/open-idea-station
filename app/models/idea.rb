class Idea < ApplicationRecord
  include UniqueIdentifier

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :viewers, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10 }

  # default values are part of domain logic and should be kept together with
  # the rest of the domain logic of the application, in the model layer.
  attribute :is_archived, :boolean, default: false
  # after_destroy :broadcast_delete
  after_save :save_categories

  attr_writer :all_categories

  def impression
    read_attribute(:impression) || 0
  end

  def slug_name
    slug = read_attribute(:slug_name) || Acorn::Normalize.slug_name(name)
    update_slug(slug)

    slug
  end

  def slug_name=(slug)
    write_attribute(:slug_name, slug)
    update_slug(slug_name)
  end

  def increment_impression
    with_lock do
      increment!(:impression)
    end
  end

  def to_param
    slug_name
  end

  # Even when we update an idea name this
  # should also get updated
  # def save
  #   self.slug_name = Acorn::Normalize.slug_name(name)
  #   Slug[slug_name] = id.to_s if Slug[slug_name].nil? || Slug[slug_name] != id.to_s

  #   super
  # end

  def update_columns(attr)
    # When archival is attempted, we want to remove 
    # all related slugs in redis store
    Slug.destroy(id) if attr[:is_archived]
    super
  end

  def uid_prefix
    "ide"
  end

  private

  def save_categories
    @all_categories&.split(",")&.each do |name|
      categories << Category.where(name: name.strip).first_or_create!
    end
  end

  def update_slug(slug)
    Slug[slug] = id.to_s if Slug[slug].nil? || Slug[slug] != id.to_s
  end

  concerning :Categories do
    included do
      has_many :idea_categories, dependent: :destroy
      has_many :categories, through: :idea_categories
    end

    def all_categories
      categories.uniq.map(&:name).join(", ")
    end
  end
end
