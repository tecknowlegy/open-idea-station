class Notification.API
  getRecentNotifications: ->
    return $.ajax(
      url: "/notifications/recent"
      type: "GET"
      success: (recentNotifications) ->
        return recentNotifications
    )
  
  markAllAsRead: (id) ->
    return $.ajax(
      url: "/notifications/mark-all-as-read/#{id}"
      type: "GET"
      success: (response) ->
        return response
    )