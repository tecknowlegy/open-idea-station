class NotificationPresenter < BasePresenter
  def picture
    @model.actor.picture || "dummy-profile-male.jpg"
  end

  def actor
    @model.actor.username
  end

  def topic
    @model.notifiable.idea
  end

  # TODO: We can have to forms of content
  # 1. Truncated `current_view.truncate(content, length: 70)` for content on dropdown
  # 2. Non-truncated for content on notifications page
  def content
    case @model.action
    when "commented" then "commented on #{topic.name}"
    else
      "#{@model.action} #{topic.name}"
    end
  end

  # TODO: change time format when it's greater than 24 hors
  # we can user <%= @model.created_at.strftime("%m/%d") %>
  def time
    "#{current_view.time_ago_in_words(@model.created_at)} ago"
  end

  def status
    @model.is_read ? "read" : "unread"
  end
end
