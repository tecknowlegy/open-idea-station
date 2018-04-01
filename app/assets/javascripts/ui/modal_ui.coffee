class Modal.UI
  constructor: (width, maxWidth, maxHeight, height) ->
    @width = width
    @maxWidth = maxWidth
    @maxHeight = maxHeight
    @height = height
  
  open: (element) ->
    self = @
    $('.modal, .modal-bottom').css("display", "block")
    $(element).dialog({
      modal: true,
      show: 'fade',
      hide: 'fade'
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
