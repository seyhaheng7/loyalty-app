Codingate.CategoriesIndex =
  init: ->
    @_initSort()

  _initSort: ->
    $('.categories_grid tbody').disableSelection()
    $('.categories_grid tbody').sortable
      handle: '.draggable'
      placeholder: 'drag-placeholder'
      stop: ->
        ids = []
        $(@).find('tr').each ->
          id = $(@).data('id')
          ids.push(id)

        $.ajax
          url: '/categories/update_order'
          method: 'PUT'
          dataType: 'json'
          data: { ids: ids }