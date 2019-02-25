$(document).on 'turbolinks:load', =>

  $notificationIcon = $(".material-icons.notification")

  if $notificationIcon.size() > 0
    App.notifications = App.cable.subscriptions.create {
      channel: "NotificationsChannel"
    },
    # Called when the subscription is ready for use on the server
    connected: ->
      console.log "connected"

    # Called when the subscription has been terminated by the server
    disconnected: ->
      console.log "disconnected"

    # Called when data is received
    received: (notifications) ->
      self = @
      self.toggleUnreadNotification()
      self.addNewNotification($(".notification-list"), notifications.html)

    toggleUnreadNotification: ->
      $(".notification-badge").addClass("status-unread")

    addNewNotification: (element, notification) ->
      self = @
      element.prepend notification