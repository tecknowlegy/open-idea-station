class Category.API
  allCategories: ->
    return $.ajax(
      url: "/categories"
      type: 'GET'
      dataType: 'json'
      success: (data) ->
        return data
    )