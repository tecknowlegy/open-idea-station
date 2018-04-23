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
                                  data-remote='true' class='acorn_btn #{self.elements.action}_btn'
                                  href='#{self.elements.actionPath}'>#{self.elements.action}
                                </a>"
                              )
      self.performAction(self.elements.actionApi)
  
  closeConfirmationModal: () =>
    self = @
    $('.close-button, .ui-widget-overlay .ui-front').on 'click', ->
      console.log 'I was clicked'
      self.closeModal()
  
  closeModal: () =>
    self = @
    self.confirmationModal.close()
    $('#confirmation-modal').css('display', 'none')
    $("body").css("overflow", "scroll")
  
  performAction: () =>
    self = @
    $(".acorn_btn").on("ajax:success", (event) ->
      alert 'Idea was successfully archived'
      self.closeModal()
    ).on "ajax:error", (event) ->
      alert 'Idea could not be archived'


