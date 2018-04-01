class Modal.App
  constructor: (@element, width, maxWidth, maxHeight, height) ->
    @ui = new Modal.UI(width, maxWidth, maxHeight, height)
  
  open: ->
    @ui.open(@element)

  close: ->
    @ui.close(@element)