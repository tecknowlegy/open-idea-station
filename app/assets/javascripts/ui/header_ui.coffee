class Header.UI
  constructor: () ->
    @$notificationIcon = $(".material-icons.notification")

  initializeSideNav: ->
    self = @
    $(".close-menu-pane, .close-bar").click ->
      self.toggleSideNav('-100%')
    
    $(".menu-pane").click ->
      self.toggleSideNav('0')

  toggleSideNav: (sideWidth) =>
    $("#side-nav").animate({ left: sideWidth })
  
  toggleHeaderDropdown: ->
    $(document).click (event) ->
      clickedElement = event.target

      if !$(clickedElement).is('.current-user') and !$(clickedElement).parents().is('.current-user')
        $(".user-profile-dropdown").addClass('hidden')

      if !$(clickedElement).is('.notification') and !$(clickedElement).parents().is('.notification')
        $(".notification-dropdown").addClass('hidden')
      
      if !$(clickedElement).is('.more-options') and !$(clickedElement).parents().is('.more-options')
        $(".more-options-dropdown").addClass('hidden')
      
      if $(clickedElement).is('.greeting')
        $(".user-profile-dropdown").removeClass('hidden')
      return

    $(".current-user").click ->
      $(".user-profile-dropdown").toggleClass('hidden')
      return

    $(".notification").click ->
      $(".notification-dropdown").toggleClass('hidden')
      return

    $(".more-options").click ->
      $(".more-options-dropdown").toggleClass('hidden')
      return
  
  fixOnScroll: ->
    $('.main-nav').addClass 'no-shadow'
    $(window).scroll ->
      $pageTray = $('#page-tray')
      $mainNav = $('.main-nav')
      scroll = $(window).scrollTop()
      if scroll >= 200
        $pageTray.addClass 'fixed'
        $mainNav.removeClass 'no-shadow'
      else
        $pageTray.removeClass 'fixed'
        $mainNav.addClass 'no-shadow'
      return

  toggleUnreadNotification: ->
    $(".notification-badge").addClass("status-unread")
  
  toggleReadNotification: ->
    $(".notification-badge").removeClass("status-unread")
  
  recentNotification: (checkRecentNotifications) ->
    self = @
    $notificationList = $(".notification-list")
    if self.$notificationIcon.size() > 0
      checkRecentNotifications(self.size).then(
        (response) ->
          if response.has_unread
            self.toggleUnreadNotification()
          
          if response.data.length is 0
            $notificationList.append """<i class='material-icons light-color4'>work_outline</i>"""
            $(".notification-footer").addClass("hidden")
            $(".footer-divider").addClass("hidden")

        (error) ->
          $notificationList.append """<p>An error occured while retrieving your notifications</p>"""
      )
    return

  markAllAsRead: (markAllAsRead) ->
    self = @
    self.$notificationIcon.click ->
      $currentUserId = $(".current-user").attr('id')
      markAllAsRead($currentUserId).then(
        (response) ->
          self.toggleReadNotification()
        (error) ->
          self.toggleUnreadNotification()
      )
