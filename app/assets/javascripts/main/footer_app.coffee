class Footer.App
  constructor: ()->
    @footerUI = new Footer.UI
    @pageUrl = new PageUrl.App

  start: ->
    currentLocation = @pageUrl.start()
    @footerUI.initialize(currentLocation)
