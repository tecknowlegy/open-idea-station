class Login.App
  constructor: ->
    @ui = new Login.UI()

  start: =>
    @ui.showLoginForm()