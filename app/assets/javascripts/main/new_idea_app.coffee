class NewIdea.App
  constructor: ->
    @newIdeaUI = new NewIdea.UI

  start: =>
    @newIdeaUI.initializeNewIdeaForm()
    @newIdeaUI.setTagsParameter()
