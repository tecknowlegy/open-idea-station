class IdeaPresenter < BasePresenter
  def author
    @author ||= User.find_by(id: @model.user_id)
  end

  def author_name
    author.username&.titleize
  end

  def author_avatar
    author.picture.present? ? image_tag(author.picture) : author_name[0,2]
  end

  def name
    @model.name.titleize
  end

  def view_count
    @model.viewers.size
  end

  def comment_count
    @model.comments.size
  end

  def publication_status
    if @model.published_at?
      "Published #{current_view.time_ago_in_words(@model.published_at)} ago"
    else
      "Draft"
    end
  end

  def publish_date
    "#{current_view.time_ago_in_words(@model.published_at)} ago"
  end

  def tags
    return @model.all_categories unless @model.all_categories.blank?

    "No tags have been added"
  end
end
