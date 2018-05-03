class ConfirmationModal.UI
  constructor: ->
    @elements = {
      actionTitle: 'Confirmation Modal',
      action: 'confirm',
      actionPath: ''
      actionButton: '.confirm'
    }
    @confirmationModal = new Modal.App('#confirmation-modal', 500, 500, 300, 300)

  showConfirmationModal: (elements) =>
    self = @
    if elements
      self.elements = elements
  
    $(self.elements['actionButton']).click =>
      self.confirmationModal.open()
      $('#confirmation-modal').css('display', 'block')
      $("body").css("overflow", "hidden")
      $('.modal-content').html(
                                "<h6 class='title'>#{self.elements.actionTitle}</h6>
                                <a 
                                  data-method=#{self.elements.actionMethod}
                                  data-remote='false' class='acorn_btn #{self.elements.action}_btn'
                                  href='#{self.elements.actionPath}'>#{self.elements.action}
                                </a>"
                              )
      self.performArchive()
  
  closeConfirmationModal: () =>
    self = @
    $('.close-button, .ui-widget-overlay .ui-front').on 'click', ->
      self.closeModal()
  
  closeModal: () =>
    self = @
    self.confirmationModal.close()
    $('#confirmation-modal').css('display', 'none')
    $("body").css("overflow", "scroll")
  
  performArchive: () =>
    self = @
    $(".acorn_btn").on 'click', ->
      self.closeModal()
      


