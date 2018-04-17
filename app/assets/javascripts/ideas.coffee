# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready =>
  newIdea = new NewIdea.App()
  newIdea.start()

  if (pageUrl[2] == 'new' || pageUrl[3] == 'edit')
    textarea = document.querySelector('#idea_description')

    autosize = ->
      el = this
      setTimeout (->
        el.style.cssText = 'height:auto; padding:0'
        # for box-sizing other than "content-box" use:
        el.style.cssText = 'box-sizing:content-box';
        el.style.cssText = 'height:' + el.scrollHeight + 'px'
        return
      ), 0
      return

    textarea.addEventListener 'keydown', autosize