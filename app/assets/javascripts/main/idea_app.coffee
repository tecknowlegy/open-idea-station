class Idea.App
  constructor: ->
    @newIdeaUI = new Idea.UI

  start: =>
    @newIdeaUI.initializeNewIdeaForm()
    @newIdeaUI.setTagsParameter()
