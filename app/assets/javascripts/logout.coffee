# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready =>
  $(document).click (event) ->
    clickedElement = event.target
    if !$(clickedElement).is('.current-user') and !$(clickedElement).parents().is('.current-user')
      $(".user-profile-dropdown").css('display', 'none')
    return

  $(".current-user").click ->
    $userProfile = $(".user-profile-dropdown")
    if $userProfile.css('display') is 'none'
      $userProfile.css('display', 'block')
    else
      $userProfile.css('display', 'none')
    return
  
