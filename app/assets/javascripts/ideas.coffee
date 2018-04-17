# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready =>
  if (pageUrl[2] == 'new' || pageUrl[3] == 'edit')
    newIdea = new NewIdea.App()
    newIdea.start()

  $('#new_idea_form').on 'keypress', (event) ->
    if event.keyCode == 13 and $('#idea_description').is(':focus') == false 
      return false
    return

