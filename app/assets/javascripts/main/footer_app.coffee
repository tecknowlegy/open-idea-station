class Footer.App
  constructor: ()->
    @footerUI = new Footer.UI

  start: ->
    @footerUI.initialize()