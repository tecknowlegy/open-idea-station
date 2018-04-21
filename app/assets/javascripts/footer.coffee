$(document).on 'turbolinks:load', =>
  if (
    pageUrl[1] == '' ||
    pageUrl[1] == 'signup' ||
    pageUrl[2] == 'new' ||
    pageUrl[3] == 'edit'
  )
    footer = new Footer.App
    footer.start()