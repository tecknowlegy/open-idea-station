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

  def content
    case @model.action
    when "commented" then "commented on #{topic.name}"
    else
      "#{@model.action} #{topic.name}"
    end
  end

  def time
    "#{current_view.time_ago_in_words(@model.created_at)} ago"
  end

  def status
    @model.is_read ? "read" : "unread"
  end
end
