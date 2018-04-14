$(document).ready ->
  if (pageUrl[1] == '' || pageUrl[1] == 'signup')
    footer = new Footer.App
    footer.start()