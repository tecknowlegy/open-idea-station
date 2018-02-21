class Modal.UI
  constructor: (width, maxWidth, height, maxHeight) ->
    @width = width
    @maxWidth = maxWidth
    @height = height
    @maxHeight = maxHeight

  open: (element) ->
    self = @
    $('.modal, .modal-bottom').css("display", "block")
    $(element).dialog({
      modal: true,
      responsive: true,
      width: self.width,
      maxWidth: self.maxWidth,
      maxHeight: self.maxHeight,
      height: self.height,
      fluid: true,
      resizable: false
    },'position', 'center')

    $(".ui-dialog-titlebar").hide()

  close: (element)->
    $(element).dialog().dialog( "close" )