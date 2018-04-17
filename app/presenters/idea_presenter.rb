class IdeaPresenter < BasePresenter

  def author_name
    author_name = User.find(@model.user_id).username
    author_name.titleize
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
      'Draft'
    end
  end

end


