class Idea.UI
  constructor: () ->
    @categories = []
    @availableTags = []
    @populateIdeaCategories()
    @initializeIdeaDropDown()
    @regEx = /,\s*/
  
  initializeNewIdeaForm: (allCategories) ->
    self = @
    allCategories().then(
      (response) ->
        for obj in response.data
          self.availableTags.push(obj["name"])
        return self.availableTags

      (error) ->
        return error
    )

    self.persistedCategoryEntries()

    $( "#category_name" )
      # don't navigate away from the field on tab when selecting an item
      .on 'keydown', (event) ->
        if (event.keyCode == $.ui.keyCode.TAB && $(this).autocomplete("instance").menu.active)
          event.preventDefault();
      .autocomplete({
        source: (request, response) =>
          #delegate back to autocomplete, but extract the last term
          response($.ui.autocomplete.filter(self.availableTags, request.term.split(self.regEx).pop()));
        autoFocus: true,
        appendTo: ".selector",
        minLength: 1,
        position: { my : "left bottom", at: "left top", of: "#category_name" }
        select: ( event, ui ) ->
          terms = this.value.split(self.regEx); 
          # remove the current input
          terms.pop();
          # add the selected item
          terms.push( ui.item.value );
          # add placeholder to get the comma-and-space at the end
          terms.push( "" );
          this.value = terms.join( ", " );
          return false;
      });
  
  selectedCategoryEntries: =>
    categories = []
    $('.mdl-chip__text').each (index, element) ->
      categories.push element.textContent
    return categories
  
  saveToLocalStorage: =>
    self = @
    localStorage.setItem("selectedCategories", self.selectedCategoryEntries())

  renderCategory: (categoryEntries) =>
    self = @
    for categoryEntry, index in categoryEntries
      if categoryEntry == ""
        return
      if categoryEntries.length >= 1 && !self.selectedCategoryEntries().includes("#{categoryEntry}")
        $('.category_tags').append """
            <span class="mdl-chip mdl-chip--deletable acorn_modified_chip" id="category-#{index}">
              <span class="mdl-chip__text">#{categoryEntry}</span>
              <button type="button" class="mdl-chip__action"><i class="material-icons remove-chip">close</i></button>
            </span>
            """
        $("#category-#{index} > button").on 'click', ->
          $(this).parent().remove()
          # ensure to update localstorage with the change when user removes a selected entry
          self.saveToLocalStorage()


  # This method retrieves initially selected categories for page reload
  persistedCategoryEntries: =>
    self = @
    categories = localStorage.getItem("selectedCategories").split(self.regEx)
    self.renderCategory(categories)
  
  populateIdeaCategories: =>
    self = @
    $('input[name="idea[all_categories]"]').on 'keydown', (event) ->
      if event.keyCode == 13
        newCategoryEntries = $('input[name="idea[all_categories]"]').val().trim().split(self.regEx)
        # clear out the input field after enter button
        $('input[name="idea[all_categories]"]').val('')
        
        self.renderCategory(newCategoryEntries)
        # Always persist selected entries when user confirms entry by pushiong enter
        self.saveToLocalStorage()
    
  initializeIdeaDropDown: =>
    $(document).click (event) ->
      clickedElement = event.target
      if !$(clickedElement).is('.new-idea-action') and !$(clickedElement).parents().is('.new-idea-action')
        $(".idea-action-dropdown").addClass('hidden')
      return

    $(".new-idea-action").click ->
      $(".idea-action-dropdown").toggleClass('hidden')
      return
  
  setTagsParameter: () =>
    self = @
    $('#draft_btn, #publish_btn').on 'click', ->
      $('input[name="idea[all_categories]"]').val(self.selectedCategoryEntries())
  