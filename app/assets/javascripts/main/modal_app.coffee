class Modal.App
  constructor: (@element, width, maxWidth, height, maxHeight) ->
    @ui = new Modal.UI(width, maxWidth, height, maxHeight)
  
  open: ->
    @ui.open(@element)

  close: ->
    @ui.close(@element)