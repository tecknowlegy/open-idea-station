class Header.App
  constructor: ->
    @headerUI = new Header.UI()
  
  start: ->
    @headerUI.initializeSideNav()
    @headerUI.toggleHeaderDropdown()
    @headerUI.fixOnScroll()