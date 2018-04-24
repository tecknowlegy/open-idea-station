$(document).on 'turbolinks:load', =>
  header = new Header.App()
  header.start()
  # getMenuBar: (element) ->
  #   $(element).find('span')

  # colorSpan: ->
  #   allSpan = getMenuBar('.menu-panel')
  #   allSpan.css('background', 'green')
