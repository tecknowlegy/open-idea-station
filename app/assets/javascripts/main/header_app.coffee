class Header.App
  constructor: ->
    @headerUI = new Header.UI()
    @notificationAPI = new Notification.API()
  
  start: ->
    @headerUI.initializeSideNav()
    @headerUI.toggleHeaderDropdown()
    @headerUI.fixOnScroll()

    # ensure this call is not made when we access notification page
    @headerUI.recentNotification(@notificationAPI.checkRecentNotifications)
    @headerUI.markAllAsRead(@notificationAPI.markAllAsRead)
