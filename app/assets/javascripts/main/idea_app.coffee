class Idea.App
  constructor: ->
    @newIdeaUI = new Idea.UI
    @categoryAPI = new Category.API

  start: =>
    @newIdeaUI.initializeNewIdeaForm(@categoryAPI.allCategories)
    @newIdeaUI.setTagsParameter()
