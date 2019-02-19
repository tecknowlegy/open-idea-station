class Header.UI
# if !$(clickedElement).is(".menu-pane") and !$(clickedElement).parents().is(".menu-pane")
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
      if scroll >= 160
        $pageTray.addClass 'fixed'
        $mainNav.removeClass 'no-shadow'
      else
        $pageTray.removeClass 'fixed'
        $mainNav.addClass 'no-shadow'
      return