class Login.App
  constructor: ->
    @loginUI = new Login.UI

  start: =>
    @loginUI.showLoginForm()
    @loginUI.closeLoginModal()