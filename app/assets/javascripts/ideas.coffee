# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', =>
  pageUrl = new PageUrl.App
  currentLocation = pageUrl.start()
  
  if (currentLocation[1] == 'ideas' && currentLocation[2] == 'new' || currentLocation[3] == 'edit')
    newIdea = new Idea.App()
    newIdea.start()

    $('#new_idea_form').on 'keypress', (event) ->
      if event.keyCode == 13 and $('#idea_description').is(':focus') == false 
        return false
      return
  
  if currentLocation[1] == 'ideas'
    confirmationModal = new ConfirmationModal.App()
    confirmContext = {
      actionTitle: 'Are you sure you want to archive this idea?',
      actionMethod: 'delete'
      action: 'archive',
      actionPath: "/ideas/#{currentLocation[2]}"
      actionButton: '.archive-idea'
    }
    confirmationModal.start(confirmContext)

  # Ensure selected categories is only persistent for new and edit idea page
  if (!currentLocation.includes("edit", "new"))
    localStorage.setItem("selectedCategories", [])