# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready =>
  $(".current-user").click =>
    $logoutBtn = $(".logout-btn") 
    if $logoutBtn.hasClass('hide-btn')
      $logoutBtn.removeClass('hide-btn')
    else
      $logoutBtn.addClass('hide-btn')
  

