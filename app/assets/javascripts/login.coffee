$(document).on 'turbolinks:load', =>
  login = new Login.App()
  login.start()