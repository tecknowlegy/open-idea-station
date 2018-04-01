class Login.UI
  constructor: ->
    @loginModal = new Modal.App('#login-modal', 760, 700, 400, 400)

  showLoginForm: () =>
    self = @
    $('.login-user').click =>
      self.loginModal.open()
      $('#login-modal').css('display', 'block')
      $("body").css("overflow", "hidden")
  
  closeLoginModal: () =>
    self = @
    $('.close-button, .ui-widget-overlay').on 'click', ->
      self.loginModal.close()
      $('#login-modal').css('display', 'none')
      $("body").css("overflow", "scroll")
