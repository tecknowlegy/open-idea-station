# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(window).scroll ->
    distanceFromTop = $(window).scrollTop();
    $('.create-idea-button').attr('disabled', false);
		if distanceFromTop > 10
			$('.create-idea-Button').attr('disabled', true);