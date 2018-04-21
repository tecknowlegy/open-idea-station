$(document).on 'turbolinks:load', =>
  getMenuBar: (element) ->
    $(element).find('span')

  colorSpan: ->
    allSpan = getMenuBar('.menu-panel')
    allSpan.css('background', 'green')
