class Notification.API
  getRecentNotifications: ->
    return $.ajax(
      url: "/notifications/recent"
      type: "GET"
      success: (recentNotifications) ->
        return recentNotifications
    )
  
  markAllAsRead: (user_id) ->
    return $.ajax(
      url: "/notifications/mark-all-as-read/#{user_id}"
      type: "GET"
      success: (response) ->
        return response
    )