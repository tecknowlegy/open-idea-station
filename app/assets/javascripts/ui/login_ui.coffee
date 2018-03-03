class Login.UI
  constructor: ->
    @loginModal = new Modal.App('#login-modal', 850, 930, 513, 513)

  showLoginForm: () =>
    self = @
    $('.login-user').click =>
      self.loginModal.open()
      $('.close-button, .ui-widget-overlay, .close-login').click ->
        self.modal.close()
