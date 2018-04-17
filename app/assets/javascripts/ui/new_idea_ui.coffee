class NewIdea.UI
  constructor: () ->
    @categories = []
    @availableTags = []
    @showIdeaCategories()
    @initializeIdeaDropDown()
  
  initializeNewIdeaForm: () ->
    self = @
    self.availableTags = [
      "ActionScript",
      "AppleScript",
      "Asp",
      "BASIC",
      "C",
      "C++",
      "Clojure",
      "COBOL",
      "ColdFusion",
      "Erlang",
      "Fortran",
      "Groovy",
      "Haskell",
      "Java",
      "JavaScript",
      "Lisp",
      "Perl",
      "PHP",
      "Python",
      "Ruby",
      "Scala",
      "Scheme"
    ];

    $( "#category_name" ).autocomplete({
      source: self.availableTags,
      autoFocus: true,
      appendTo: ".selector",
      minLength: 1,
      position: { my : "left bottom", at: "left top", of: "#category_name" }
    });

  getIdeaCategories: =>
    categories = []
    $('.mdl-chip__text').each (index, element) ->
      categories.push element.textContent
    return categories
  
  showIdeaCategories: =>
    self = @
    categoryNumber = 1
    $categoryInput = $('input[name="idea[all_categories]"]')
    $('input[name="idea[all_categories]"]').on 'keydown', (event) ->
      if event.keyCode == 13
        newCategory = $('input[name="idea[all_categories]"]').val().trim()
        allCategories = self.getIdeaCategories()
        $('input[name="idea[all_categories]"]').val('')
        if newCategory.length >= 1 && !allCategories.includes("#{newCategory}")
          $('.category_tags').append """
            <span class="mdl-chip mdl-chip--deletable acorn_modified_chip" id="category-#{categoryNumber}">
              <span class="mdl-chip__text">#{newCategory}</span>
              <button type="button" class="mdl-chip__action"><i class="material-icons remove-chip">close</i></button>
            </span>
            """

          $("#category-#{categoryNumber} > button").on 'click', ->
            $(this).parent().remove()
          categoryNumber += 1
    
  initializeIdeaDropDown: =>
    $(document).click (event) ->
      clickedElement = event.target
      if !$(clickedElement).is('.new-idea-action') and !$(clickedElement).parents().is('.new-idea-action')
        $(".idea-action-dropdown").addClass('hidden')
      return

    $(".new-idea-action").click ->
      $newIdeaAction = $(".idea-action-dropdown")
      if $newIdeaAction.hasClass('hidden')
        $newIdeaAction.removeClass('hidden')
      else
        $newIdeaAction.addClass('hidden')
      return
  
  setTagsParameter: () =>
    self = @
    $('#draft_btn, #publish_btn').on 'click', ->
      $('input[name="idea[all_categories]"]').val(self.getIdeaCategories())
  
